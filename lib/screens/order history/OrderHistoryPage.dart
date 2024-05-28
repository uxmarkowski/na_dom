import 'package:flutter/material.dart';
import 'package:na_dom/Widgets/appAndBottomBars/AppBarWidget.dart';
import 'package:na_dom/Widgets/generalCustomWidgets/CustomButton.dart';
import 'package:na_dom/Widgets/orderHistory/OrderInHistoryWidget.dart';
import 'package:na_dom/design.dart';

import '../../Widgets/appAndBottomBars/BottomNavigationBarWidget.dart';
import '../catalog/AllTypesOfCormPage.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}



class _OrderHistoryPageState extends State<OrderHistoryPage> {
  var haveSomeOrders = true;
  var indexOfPage = 0;
  List listOfOrders = [];
  List futureListOfOrders = [];
  List deliveredListOfOrders = [];
  List canceledListOfOrders = [];

  void getOrdersFromFireBse () async {
    var _collection = await ref.child("orders").get();
    var collectionChildren = _collection.children.toList();

    await Future.forEach(collectionChildren, (doc) {
      var data = doc.value as Map;
      setState(() {
        listOfOrders.add(data);
      });
      if (data["status"] == "В обработке" || data["status"] == "В пути" ) {
        setState(() {
          futureListOfOrders.add(data);
        });
      } else if (data["status"] == "Доставлен") {
        setState(() {
          deliveredListOfOrders.add(data);
        });
      } else if (data["status"] == "Отменён") {
        setState(() {
          canceledListOfOrders.add(data);
        });
      }
    });



  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrdersFromFireBse();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
          context: context,
          showSearchIcon: true,
          showContactsIcon: true,
          showPersonalPageIcon: false,
          showFaworiteIcon: false,
          showDeleteIcon: false
      ),
      bottomNavigationBar: BottomNavigationBarWidget(currentBottomBarIndex: 2, context: context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 16,),
                Text("История заказов", style: textStyleB1,),
              ],
            ),
            SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      indexOfPage = 0;
                    });
                  },
                  child: Text("Все", style: indexOfPage == 0 ? textStyleB4 : textStyleL4,),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      indexOfPage = 1;
                    });
                  },
                  child: Text("Предстоящие", style: indexOfPage == 1 ? textStyleB4 : textStyleL4,),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      indexOfPage = 2;
                    });
                  },
                  child: Text("Выполненые", style: indexOfPage == 2 ? textStyleB4 : textStyleL4,),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      indexOfPage = 3;
                    });
                  },
                  child: Text("Отмененные", style: indexOfPage == 3 ? textStyleB4 : textStyleL4,),
                ),
              ],
            ),
            SizedBox(height: 4,),
            Divider(
              color: Color.fromRGBO(217, 217, 217, 1),
              thickness: 1,
            ),
            if (indexOfPage == 0) Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  children: listOfOrders.isEmpty ? [
                    SizedBox(height: 36,),
                    Container(
                      height: 300,
                      width: 250,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("lib/assets/dogOrderHistoryImage.png",)
                          )
                      ),
                    ),
                    SizedBox(height: 24,),
                    Text("У вас пока нет ", style: textStyleB2,),
                    Text("предстоящих заказов", style: textStyleB2,),
                    SizedBox(height: 48,),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: MyButton(
                            onTap: (){
                              Navigator.pushNamed(context, "/catalogPage");
                            },
                            text: "Перейти в классификатор")
                    ),
                    SizedBox(height: 36,)
                  ] : [
                    SizedBox(height: 36,),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return OrderInHistoryWidget(
                              price: (listOfOrders[index]["price"]["totalPrice"] * (1 - (listOfOrders[index]["price"]["discount"]) / 100) as double).round(),
                              date: (listOfOrders[index]["status"] == "Неоплачен" || listOfOrders[index]["status"] == "Отменён") ? listOfOrders[index]["data"]["orderDate"] : listOfOrders[index]["data"]["deliveryDate"],
                              images: listOfOrders[index]["images"],
                              context: context,
                              status: listOfOrders[index]["status"],
                              deliveryStatus: listOfOrders[index]["deliveryStatus"]=="Доаставка курьером" ? "Доставка курьером" : listOfOrders[index]["deliveryStatus"],
                              order: listOfOrders[index],
                          );
                        },
                        separatorBuilder: (context, index){
                          return Column(
                            children: [
                              SizedBox(height: 24,),
                              Divider(
                                color: Color.fromRGBO(0, 0, 0, 0.2),
                                thickness: 1,
                              ),
                              SizedBox(height: 24,),
                            ],
                          );
                        },
                        itemCount: listOfOrders.length
                    ),
                    SizedBox(height: 56,)
                  ]
              ),
            ),
            if (indexOfPage == 1) Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 36,),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return OrderInHistoryWidget(
                          price: (futureListOfOrders[index]["price"]["totalPrice"] * (1 - (listOfOrders[index]["price"]["discount"]) / 100) as double).round(),
                          date: futureListOfOrders[index]["status"] == "Неоплачен" ? listOfOrders[index]["data"]["orderDate"] : listOfOrders[index]["data"]["deliveryDate"],
                          images: futureListOfOrders[index]["images"],
                          context: context,
                          status: futureListOfOrders[index]["status"],
                          deliveryStatus: futureListOfOrders[index]["deliveryStatus"],
                          order: futureListOfOrders[index],
                        );
                      },
                      separatorBuilder: (context, index){
                        return Column(
                          children: [
                            SizedBox(height: 24,),
                            Divider(
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                              thickness: 1,
                            ),
                            SizedBox(height: 24,),
                          ],
                        );
                      },
                      itemCount: futureListOfOrders.length
                  ),
                  SizedBox(height: 56,),


                ],
              ),
            ),
            if (indexOfPage == 2) Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 36,),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return OrderInHistoryWidget(
                          price: (deliveredListOfOrders[index]["price"]["totalPrice"] * (1 - (listOfOrders[index]["price"]["discount"]) / 100) as double).round(),
                          date: deliveredListOfOrders[index]["status"] == "Неоплачен" ? listOfOrders[index]["data"]["orderDate"] : listOfOrders[index]["data"]["deliveryDate"],
                          images: deliveredListOfOrders[index]["images"],
                          context: context,
                          status: deliveredListOfOrders[index]["status"],
                          deliveryStatus: deliveredListOfOrders[index]["deliveryStatus"],
                          order: deliveredListOfOrders[index],
                        );
                      },
                      separatorBuilder: (context, index){
                        return Column(
                          children: [
                            SizedBox(height: 24,),
                            Divider(
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                              thickness: 1,
                            ),
                            SizedBox(height: 24,),
                          ],
                        );
                      },
                      itemCount: deliveredListOfOrders.length
                  ),
                  SizedBox(height: 56,),
                ],
              ),
            ),
            if (indexOfPage == 3) Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 36,),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return OrderInHistoryWidget(
                          price: (canceledListOfOrders[index]["price"]["totalPrice"] * (1 - (listOfOrders[index]["price"]["discount"]) / 100) as double).round(),
                          date: canceledListOfOrders[index]["status"] == "Неоплачен" ? listOfOrders[index]["data"]["orderDate"] : listOfOrders[index]["data"]["deliveryDate"],
                          images: canceledListOfOrders[index]["images"],
                          context: context,
                          status: canceledListOfOrders[index]["status"],
                          deliveryStatus: canceledListOfOrders[index]["deliveryStatus"],
                          order: canceledListOfOrders[index],
                        );
                      },
                      separatorBuilder: (context, index){
                        return Column(
                          children: [
                            SizedBox(height: 24,),
                            Divider(
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                              thickness: 1,
                            ),
                            SizedBox(height: 24,),
                          ],
                        );
                      },
                      itemCount: canceledListOfOrders.length
                  ),
                  SizedBox(height: 56,),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
