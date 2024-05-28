import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:na_dom/Widgets/appAndBottomBars/AppBarWidget.dart';
import 'package:na_dom/Widgets/generalCustomWidgets/CustomButton.dart';
import 'package:na_dom/design.dart';

import '../../Widgets/custom_route.dart';
import '../../Widgets/orderHistory/OrderProductWidget.dart';
import '../../Widgets/productWidgets/TowarInCartWidget.dart';
import '../../Widgets/generalCustomWidgets/UserWidget.dart';
import '../catalog/AllTypesOfCormPage.dart';
import '../catalog/ProductPage.dart';


class OrderDetailsPage extends StatefulWidget {
  final order;
  const OrderDetailsPage({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {


  var listOfProducts = [];

  void getProductsFromFireBase () async {
    var _collection = await ref.child("products").get();
    var collectionChildren = _collection.children.toList();



    Future.forEach(widget.order["productsID"], (docID) {

      collectionChildren.forEach((product) {
        var data = product.value as Map;
        if (data["docID"] == docID) {
          listOfProducts.add(data);
        }
      });

    });

    print("listOfProducts after: $listOfProducts");
    setState(() {});
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductsFromFireBase();
    print(widget.order);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
          context: context,
          showSearchIcon: true,
          showContactsIcon: true,
          showPersonalPageIcon: true,
          showFaworiteIcon: false,
          showDeleteIcon: false
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 36,),
              Text("Доставка ${widget.order["data"]["deliveryDate"]}", style: textStyleB1,),
              SizedBox(height: 12,),
              Text("10:00 – 16:00 вторник", style: TextStyle(color: colorGrey3, fontSize: 16),),
              SizedBox(height: 24,),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return OrderProductWidget(
                      context: context,
                      image: listOfProducts[index]["listOfImages"][0],
                      title: listOfProducts[index]["title"],
                      price: listOfProducts[index]["price"],
                      count: listOfProducts[index]["countOfTowar"],
                      widgetIsFaworite: listOfProducts[index]["widgetIsFaworite"],
                      docID: listOfProducts[index]["docID"],
                      index: index,
                      functionTransition: () {
                        final page = ProductPage(docID: listOfProducts[index]["docID"]);
                        Navigator.of(context).push(CustomPageRoute2(page)).then((value) {
                          // getProductsForThisScreenInitState();
                        });
                        incrementPopularity( productID: listOfProducts[index]["docID"]);
                      }
                  );
                },
                separatorBuilder: (context, index){
                  return SizedBox(height: 24,);
                },
                itemCount: listOfProducts.length,
              ),
              Text("Доставка и оплата", style: textStyleB3,),
              SizedBox(height: 24,),
              UserWidget(name: widget.order["name"], phoneNumber: auth.currentUser!.phoneNumber.toString()),
              SizedBox(height: 16,),
              Divider(
                color: colorDevider,
                thickness: 1,
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  SvgPicture.asset("lib/assets/solar_bill-check-bold.svg"),
                  SizedBox(width: 12,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Оплата картой при получении", style: textStyleB4,),
                      SizedBox(height: 4,),
                      Text(widget.order["status"], style: textStyleL4Grey06,),
                    ],
                  )
                ],
              ),
              SizedBox(height: 16,),
              Divider(
                color: colorDevider,
                thickness: 1,
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  SvgPicture.asset("lib/assets/fa-solid_shuttle-van.svg"),
                  SizedBox(width: 12,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget.order["address"]["city"]}${widget.order["address"]["street, house"]}", style: textStyleB4,),
                      SizedBox(height: 4,),
                      Text("«Спущусь»", style: textStyleL4Grey06,),
                    ],
                  )
                ],
              ),
              SizedBox(height: 36,),
              MyButton(onTap: (){}, text: "Оплатить"),
              SizedBox(height: 36,),

            ],
          ),
        ),
      ),
    );
  }
}
