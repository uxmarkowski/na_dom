import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:na_dom/Widgets/appAndBottomBars/AppBarWidget.dart';
import 'package:na_dom/Widgets/generalCustomWidgets/CustomButton.dart';
import 'package:na_dom/Widgets/generalCustomWidgets/CustomTextField.dart';
import 'package:na_dom/Widgets/generalCustomWidgets/UserWidget.dart';
import 'package:na_dom/design.dart';

import '../../Widgets/cartPage/SelectTheDeliveryDateWidget.dart';
import '../../Widgets/custom_route.dart';
import '../../Widgets/hive_metod.dart';
import '../../Widgets/scaffold_message.dart';
import '../catalog/AllTypesOfCormPage.dart';
import 'DeliveryAddressPage.dart';

class PlacingAnOrderPage extends StatefulWidget {
  const PlacingAnOrderPage({Key? key}) : super(key: key);

  @override
  State<PlacingAnOrderPage> createState() => _PlacingAnOrderPageState();
}

class _PlacingAnOrderPageState extends State<PlacingAnOrderPage> {

  @override
  void initState() {
    super.initState();
    getOrderDates(timeOfDelivery);
    createOrder();
  }

  var timeOfDelivery = 1;
  var countOfShowingDays = 33;
  var haveUserInfo = false;


  DateTime now = DateTime.now();
  List<String> dates = [];
  List<String> days = [];
  var indexActiveWidget = 0;
  var tommorow;
  var today;

  List cart = [];
  Map order = {
    "status" : "Неоплачен",
    "deliveryStatus" : "",
    "productsID" : [],
    "images" : [],
    "price" : {
      "totalPrice" : 0,
      "discount" : 0,
      "productsPrice": [],
    },
    "data" : {
      "orderDate" : "",
      "deliveryDate" : "",
      "delyveryDay" : "",
    },
    "address" : {
      "city" : "",
      "street, house" : "",
      "entrance" : "",
      "apartment" : "",
      "comment" : "",
    },
    "orderComment" : "",
    "orderID" : "",
    "name" : "",
    "number" : "",
  };

  static String _getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return 'Понедел';
      case 2:
        return 'Вторник';
      case 3:
        return 'Среда';
      case 4:
        return 'Четверг';
      case 5:
        return 'Пятница';
      case 6:
        return 'Суббота';
      case 7:
        return 'Воскр';
      default:
        return '';
    }
  }
  String getNameOfMonth (monthData) {
    switch (monthData) {
      case 1:
        return 'янв';
      case 2:
        return 'фев';
      case 3:
        return 'мар';
      case 4:
        return 'апр';
      case 5:
        return 'мая';
      case 6:
        return 'июн';
      case 7:
        return 'июл';
      case 8:
        return 'авг';
      case 9:
        return 'сен';
      case 10:
        return 'окт';
      case 11:
        return 'ноя';
      case 12:
        return 'дек';
      default:
        return '';
    }
  }

  void getOrderDates (int timeOfDelivering) {

    DateTime tomorrowDate = now.add(Duration(days: (1)));
    tommorow = '${tomorrowDate.day} ${getNameOfMonth(tomorrowDate.month)}';


    for (int i = 0; i < countOfShowingDays; i++) {
      var shift = 1;
      DateTime date = now.add(Duration(days: (i + timeOfDelivering)));
      DateTime tomorrowDate = now.add(Duration(days: (1)));
      String dayOfWeek = _getDayOfWeek(date.weekday);
      // print(date);
      // print(dayOfWeek);


      String dateStr = '${date.day} ${getNameOfMonth(date.month)}';
      dates.add('$dateStr');
      days.add('$dayOfWeek');
    }

  }

  void updateIndexOfAcitveWidget (int index) {
    setState(() {
      indexActiveWidget = index;
    });
    order["data"]["deliveryDate"] = dates[indexActiveWidget];
    order["data"]["orderDate"] = today;

  }

  void createOrder ( ) async {
    var _collection = await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("userInfo").child("personalInfo").get();
    print("colltexti ${_collection.value.toString()}");

    DateTime todatDate = now.add(Duration(days: (0)));
    today = '${todatDate.day} ${getNameOfMonth(todatDate.month)}';
    String dayOfWeekk = _getDayOfWeek(todatDate.weekday);
    order["data"]["deliveryDate"] = dates[indexActiveWidget];
    order["data"]["orderDate"] = today;
    order["data"]["delyveryDay"] = dayOfWeekk;



    if (_collection.exists) {

      if ((_collection.value as Map)["FIO"] != "") {
        setState(() {
          haveUserInfo = true;
          order["name"] = (_collection.value as Map)["FIO"];
        });
      } else {
        setState(() {
          haveUserInfo = false;
        });
      }


    }

    cart = await model.getCart();
    print("cart $cart");
    var i = 0;
    cart.forEach((element) {
      // расчёт цены
      if (element["discount"] != 0) {
        order["price"]["totalPrice"] = order["price"]["totalPrice"] + (element["price"][ element["сhoosenCormMassIndex"] ] * element["countOfTowar"] * (1 - element["discount"] / 100) as double).round();
        (order["price"]["productsPrice"] as List).add((element["price"][ element["сhoosenCormMassIndex"] ] * element["countOfTowar"] * (1 - element["discount"] / 100) as double).round());
      } else {
        order["price"]["totalPrice"] = order["price"]["totalPrice"] + (element["price"][ element["сhoosenCormMassIndex"] ] * element["countOfTowar"] as double).round();
        (order["price"]["productsPrice"] as List).add((element["price"][ element["сhoosenCormMassIndex"] ] * element["countOfTowar"] * (1 - element["discount"] / 100) as double).round());
      }
      i++;
      //добавление изображений
      (order["images"] as List).add(element["listOfImages"][0]);

      //добавление productID
      (order["productsID"] as List).add(element["docID"]);


    });

    // добавление статуса доставки
    if (firstWidgetActive) {
      order["deliveryStatus"] = "Доставка курьером";
    } else {
      order["deliveryStatus"] = "Самовывоз 5%";
    }

    // добавление даты доставки
    order["data"]["deliveryDate"] = dates[indexActiveWidget];


    order.forEach((key, value) {
      print("$key: $value");
    });





  }

  void addOrderToFireBase () async {
    var newCollection = await ref.child("orders").get();
    var newId = DateTime.now().millisecondsSinceEpoch.toString();


    if (controllerComment.text.isNotEmpty) {
      order["orderComment"] = controllerComment.text;
    }
    order["number"] = auth.currentUser!.phoneNumber.toString();

    print("order $order");
    await ref.child("orders").child(newId).set({
      "status" : "Неоплачен",
      "deliveryStatus" : order["deliveryStatus"],
      "productsID" : order["productsID"],
      "images" : order["images"],
      "price" : order["price"],
      "data" : order["data"],
      "address" : order["address"],
      "orderComment" : order["orderComment"],
      "name" : order["name"],
      "number" : order["number"],
      "orderID" : newId,
    });




}


  var firstWidgetActive = true;
  var controllerComment = TextEditingController();
  var commentFocusNode = FocusNode();

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
      body: GestureDetector(
        onTap: (){
          commentFocusNode.unfocus();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight),
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 36,),
                        Text("Оформление заказа", style: textStyleB1,),
                        SizedBox(height: 24,),
                        Text("Получатель", style: textStyleB3,),
                        SizedBox(height: 12,),
                        if (haveUserInfo == true) UserWidget(name: order["name"], phoneNumber: auth.currentUser!.phoneNumber.toString()),
                        if (haveUserInfo == false) InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, "/myDataPage").then((value) => createOrder());
                          },
                          child: Container(
                            height: 36,
                            width: 36,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: colorRed,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Icon(CupertinoIcons.plus_circle, color: Colors.white, size: 36,),
                          ),
                        ),
                        SizedBox(height: 24,),
                        Text("Способ доставки", style: textStyleB3,),
                        SizedBox(height: 12,),
                        Row(
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  firstWidgetActive = true;
                                });
                                order["price"]["discount"] = 0;
                                order["deliveryStatus"] = "Доставка курьером";
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: (MediaQuery.of(context).size.width - 40) / 2 ,
                                height: 78,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(247, 247, 247, 1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: firstWidgetActive ? colorGreen : Color.fromRGBO(201, 201, 201, 1),
                                        width: 1
                                    )
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Фирменная доставка", style: TextStyle(color: firstWidgetActive ? colorGreen : colorBlack, fontSize: 12, fontWeight: FontWeight.bold),),
                                    Text("«На дом» 0₽", style: TextStyle(color: firstWidgetActive ? colorGreen : colorBlack, fontSize: 12, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 8,),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  firstWidgetActive = false;
                                });
                                order["price"]["discount"] = 5;
                                order["deliveryStatus"] = "Самовывоз 5%";
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: (MediaQuery.of(context).size.width - 40) / 2 ,
                                height: 78,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(247, 247, 247, 1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: firstWidgetActive ? Color.fromRGBO(201, 201, 201, 1) : colorGreen,
                                        width: 1
                                    )
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Самовывоз", style: TextStyle(color: firstWidgetActive ? colorBlack : colorGreen, fontSize: 12, fontWeight: FontWeight.bold),),
                                    SizedBox(height: 4,),
                                    Text("+5% скидка ко всем", style: TextStyle(color: firstWidgetActive ? colorBlack : colorGreen, fontSize: 12, fontWeight: FontWeight.normal),),
                                    Text("товарам", style: TextStyle(color: firstWidgetActive ? colorBlack : colorGreen, fontSize: 12, fontWeight: FontWeight.normal),),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 24,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Адрес доставки", style: textStyleB3,),
                            InkWell(
                              onTap: (){
                                final page = DeliveryAddressPage(address: order["address"],);
                                Navigator.of(context).push(CustomPageRoute2(page)).then((value)  {
                                  if (value != null) {
                                    value as Map;
                                    order["address"]["city"] = value["city"];
                                    order["address"]["street, house"] = value["street, house"];
                                    order["address"]["entrance"] = value["entrance"];
                                    order["address"]["apartment"] = value["apartment"];
                                    order["address"]["comment"] = value["comment"];
                                    setState(() {});
                                  }
                                });
                              },
                              child: Row(
                                children: [
                                  if ((order as Map)["address"]["city"] == "") Icon(CupertinoIcons.plus_circle_fill, color: colorRed, size: 20,),
                                  if ((order as Map)["address"]["city"] != "") Icon(Icons.edit, color: colorRed, size: 20,),
                                  SizedBox(width: 6,),
                                  Text("${order["address"]["city"] == "" ? "Добавить" : "Измениить"}", style: TextStyle(color: colorRed, fontSize: 14, fontWeight: FontWeight.bold,), ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 24,),
                        Text("Детали заказа", style: textStyleB3,),
                        SizedBox(height: 8,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset("lib/assets/fa-solid_shuttle-van.svg"),
                            SizedBox(width: 12,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${order["address"]["city"]} ${order["address"]["street, house"]}", style: textStyleB4,),
                                SizedBox(height: 4,),
                                Text("${order["address"]["comment"] == "" ? "" : "«"}${order["address"]["comment"]}${order["address"]["comment"] == "" ? "" : "»"}", style: TextStyle(color: colorGrey3, fontWeight: FontWeight.normal,fontSize: 12),)

                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 16,),
                        Container(
                          height: 44,
                          width: double.infinity,
                          child: TextField(
                            controller: controllerComment,
                            focusNode: commentFocusNode,
                            obscureText: false,
                            style: TextStyle(color: Color.fromRGBO(102, 112, 133, 1), fontSize: 14, fontWeight: FontWeight.normal),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: colorBorderTextField),
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: colorBorderTextField),
                                    borderRadius: BorderRadius.circular(12)

                                ),
                                fillColor: Color.fromRGBO(247, 247, 247, 1),
                                filled: true,
                                hintText: "Комментарий к заказу",
                                hintStyle: TextStyle(color: colorHintText, fontSize: 14, fontWeight: FontWeight.normal)
                            ),
                          ),
                        ),
                        SizedBox(height: 24,),
                        Text("Выберите дату и время доставки", style: textStyleB3,),
                      ],
                    ),
                  ),
                  SizedBox(height: 12,),
                  SelectTheDeliveryDateWidget(
                      indexActiveWidget: indexActiveWidget,
                      function: updateIndexOfAcitveWidget,
                      dates: dates,
                      days: days,
                      tomorrow: tommorow,
                  ),
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: MyButton(
                          onTap: (){
                            if (order["name"] == "") {
                              ScaffoldMessage(context: context, message: "Заполните данные о себе");
                            } else if (order["address"]["city"] == "") {
                              ScaffoldMessage(context: context, message: "Добавьте адресс");
                            } else {
                              addOrderToFireBase();
                              cart.clear();
                              model.saveCart(cart);
                            }
                            Navigator.pushNamed(context, "/");
                          },
                          text: "Заказать"
                      ),
                  ),
                  SizedBox(height: 24,)
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}

