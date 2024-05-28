import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:na_dom/Widgets/appAndBottomBars/AppBarWidget.dart';
import 'package:na_dom/Widgets/generalCustomWidgets/CustomButton.dart';
import 'package:na_dom/design.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../Widgets/productWidgets/ProductScrollImageWidget.dart';
import '../../Widgets/productWidgets/ChooseCormMassWidget.dart';
import '../../Widgets/hive_metod.dart';
import 'AllTypesOfCormPage.dart';

class ProductPage extends StatefulWidget {
  final String docID;
  const ProductPage({Key? key, required this.docID}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {



  String costWithSpaces (cost) {
    double hundreds = 0; // число до тысячи
    double thousands = 0; // количество тысяч
    double millions = 0; // количество миллионов
    num doubleCosts = cost;
    if (cost < 1000) {
      hundreds = cost;
    } else if (cost < 1000000) {
      hundreds = doubleCosts.toDouble() % 1000;
      thousands = (doubleCosts.toDouble() - hundreds) / 1000;
    }

    String stringHundreds  = (hundreds == 0) ? '' : '${hundreds.toInt()} ';
    String stringThousands = (thousands == 0) ? '' : '${thousands.toInt()} ';

    String finalstringHundreds  = (stringHundreds == '' && thousands != 0) ? '000 ' : stringHundreds;
    String finalstringThousands = (stringThousands == '' && millions != 0) ? '000 ' : stringThousands;



    return "${finalstringThousands}${finalstringHundreds}₽";
  }

  var indexOfScreen = 0;

  Map mapOfProduct = {};
  Map brend = {};
  var classOfCorm = "";
  var typeOfCorm = "";
  var petAge = "";
  var cart = [];

  var indexOfImage = 0;
  void changeCountOfProduct (int) {
    if (int == 1) {
      setState(() { mapOfProduct["countOfTowar"]++; });
      // добавить
      if (cart.where((element) => element["docID"] == mapOfProduct["docID"]).isNotEmpty) {

        cart.removeWhere((element) => element["docID"] == mapOfProduct["docID"]);
        cart.add(mapOfProduct);
        model.saveCart(cart);

      } else {
        cart.add(mapOfProduct);
      }

    } else {
      if (mapOfProduct["countOfTowar"] > 1) {
        setState(() { mapOfProduct["countOfTowar"]--; });
        // вычесть
        if (cart.where((element) => element["docID"] == mapOfProduct["docID"]).isNotEmpty) {

          cart.removeWhere((element) => element["docID"] == mapOfProduct["docID"]);
          cart.add(mapOfProduct);
          model.saveCart(cart);

        }

      } else {
        setState(() { mapOfProduct["countOfTowar"] = 0; });
        // удаляем из корзины

        cart.removeWhere((element) => element["docID"] == mapOfProduct["docID"]);

      }

    }
    model.saveCart(cart);
    // print("cart affter $cart");
  }
  void changeImageIndex(int index, int i) {
    setState(() {
      indexOfImage = index;
    });
  }
  void functionChangeCormMassIndex (int index) {
    setState(() { mapOfProduct["сhoosenCormMassIndex"] = index; });

    if (cart.where((element) => element["docID"] == mapOfProduct["docID"]).isNotEmpty) {

      cart.removeWhere((element) => element["docID"] == mapOfProduct["docID"]);
      cart.add(mapOfProduct);
      model.saveCart(cart);

    }
    // print("cart affter $cart");
  }
  void changeFaworiteWidget () async{
    setState(() {
      mapOfProduct["widgetIsFaworite"] =! mapOfProduct["widgetIsFaworite"];
    });

    if (mapOfProduct["widgetIsFaworite"] == true) {
      // добавить в избранные
      await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("faworiteWidget").child(mapOfProduct["docID"]).set(
          {
            "price" : mapOfProduct["price"],
            "discount" : mapOfProduct["discount"],
            "title" : mapOfProduct["title"],
            "massTypes" : mapOfProduct["massTypes"],
            "сhoosenCormMassIndex" : mapOfProduct["сhoosenCormMassIndex"],
            "docID" : mapOfProduct["docID"],
            "listOfImages" : mapOfProduct["listOfImages"],
            "widgetIsFaworite" : mapOfProduct["widgetIsFaworite"],
            "countOfTowar"  : 0,
          }
      );
    } else {
      // удалить из избранных
      await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("faworiteWidget").child(mapOfProduct["docID"]).remove();
    }
  }

  void getProductForThisScreenInitState () async {
    var _collection = await ref.child("products").get();
    var collectionChildren = _collection.children.toList();

    var _collectionOfFaworiteProducts = await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("faworiteWidget").get();
    var collectionOfFaworiteProductsChildern = _collectionOfFaworiteProducts.children.toList();

    var _collectionBrend = await ref.child("brends").get();
    var collectionBrendChildren = _collectionBrend.children.toList();
    
    var _colletctionCormClass = await ref.child("categories").child("classOfCorm").get();
    var collectionCormClassChildren = _colletctionCormClass.children.toList();
    var _colletctionCormType = await ref.child("categories").child("typeOfCorm").get();
    var collectionCormTypeChildren = _colletctionCormType.children.toList();
    var _colletctionAgeOfPet = await ref.child("categories").child("ageOfPet").get();
    var collectionAgeOfPetChildren = _colletctionAgeOfPet.children.toList();

    collectionChildren.forEach((doc) {
      var data = doc.value as Map;

      if (data["docID"] == widget.docID) {

        mapOfProduct["price"] = data["price"];
        mapOfProduct["discount"] = data["discount"];
        mapOfProduct["title"] = data["title"];
        mapOfProduct["massTypes"] = data["massTypes"];
        mapOfProduct["listOfImages"] = data["listOfImages"];
        mapOfProduct["docID"] = data["docID"];
        mapOfProduct["brendID"] = data["brendID"];

        mapOfProduct["classOfCorm"] = data["classOfCorm"];
        mapOfProduct["typeOfCorm"] = data["typeOfCorm"];
        mapOfProduct["petAge"] = data["petAge"];
        mapOfProduct["petSize"] = data["petSize"];
        mapOfProduct["petActivity"] = data["petActivity"];
        mapOfProduct["specialNeeds"] = data["specialNeeds"];
        mapOfProduct["ingredients"] = data["ingredients"];
        mapOfProduct["allIngredients"] = data["allIngredients"];

        mapOfProduct["сhoosenCormMassIndex"] = 0;
        mapOfProduct["countOfTowar"] = 0;

        mapOfProduct["widgetIsFaworite"] = false;
      }
    });

    mapOfProduct["specialNeeds"] as List;

    // изменить иконку избранного если этот товар там уже есть
    collectionOfFaworiteProductsChildern.forEach((doc) {
      var faworiteProduct = doc.value as Map;
      if (faworiteProduct["docID"] == mapOfProduct["docID"]) mapOfProduct["widgetIsFaworite"] = true;
    });
    cart = await model.getCart();

    //коррекция продукта на слуачай если он есть в корзине
    if (cart.where((cartProduct) => cartProduct["docID"] == mapOfProduct["docID"]).isNotEmpty) {
      var countOfProductInCart = cart.where((element) => element["docID"] == mapOfProduct["docID"]).first["countOfTowar"];
      var indexOfCormMassInCart = cart.where((element) => element["docID"] == mapOfProduct["docID"]).first["сhoosenCormMassIndex"];

      setState(() {
        mapOfProduct["countOfTowar"] = countOfProductInCart;
        mapOfProduct["сhoosenCormMassIndex"] = indexOfCormMassInCart;
      });
    }

    //добавление информации о бренде
    await Future.forEach(collectionBrendChildren, (doc) {
      var data = doc.value as Map;
      if (data["brendID"] == mapOfProduct["brendID"]) { // подгрузить только бренд этой страницы
        brend["title"] = data["title"];
        brend["desctiption"] = data["desctiption"];
        brend["brendID"] = data["brendID"];
      }
    });

    // добавление характеристик
    await Future.forEach(collectionCormClassChildren, (doc) {
      var data = doc.value as Map;
      if (data["filterID"] == (mapOfProduct["classOfCorm"] as List).first) { // подгрузить только бренд этой страницы
        classOfCorm = data["title"];
      }
    });
    print(mapOfProduct);
    await Future.forEach(collectionCormTypeChildren, (doc) {
      var data = doc.value as Map;
      if (data["filterID"] == (mapOfProduct["typeOfCorm"] as List).first) { // подгрузить только бренд этой страницы
        typeOfCorm = data["title"];
      }
    });

    await Future.forEach(collectionAgeOfPetChildren, (doc) {
      var data = doc.value as Map;
      if (data["filterID"] == (mapOfProduct["petAge"] as List).first) { // подгрузить только бренд этой страницы
        petAge = data["title"];
      }
    });



    print(brend["title"]);

    setState((){});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductForThisScreenInitState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
          context: context,
          showSearchIcon: false,
          showContactsIcon: false,
          showPersonalPageIcon: false,
          showFaworiteIcon: true,
          showDeleteIcon: false,
          faworiteWidgetIsChoosen: mapOfProduct["widgetIsFaworite"] ?? false,
          functionOfFaworiteIcon: () {
            changeFaworiteWidget();
          }
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: mapOfProduct.isEmpty ?
        Column(
          children: [
            SizedBox(height: 36,),
            CupertinoActivityIndicator(),
          ],
        ) : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 36,), // 36
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(brend["title"],style: textStyleB1,),
            ), // 28
            SizedBox(height: 12,), // 12
            SizedBox(
              height: 16,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 16,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        indexOfScreen = 0;
                      });
                    },
                    child: Text("Описание",style: indexOfScreen == 0 ? textStyleB4 : TextStyle(color: colorGrey3, fontSize: 12, fontWeight: FontWeight.normal)),
                  ),
                  SizedBox(width: 16,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        indexOfScreen = 1;
                      });
                    },
                    child: Text("Характеристики",style: indexOfScreen == 1 ? textStyleB4 : TextStyle(color: colorGrey3, fontSize: 12, fontWeight: FontWeight.normal),),
                  ),
                  SizedBox(width: 16,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        indexOfScreen = 2;
                      });
                    },
                    child: Text("Ингридиенты",style: indexOfScreen == 2 ? textStyleB4 : TextStyle(color: colorGrey3, fontSize: 12, fontWeight: FontWeight.normal),),
                  ),
                  SizedBox(width: 16,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        indexOfScreen = 3;
                      });
                    },
                    child: Text("О бренде",style: indexOfScreen == 3 ? textStyleB4 : TextStyle(color: colorGrey3, fontSize: 12, fontWeight: FontWeight.normal),),
                  ),
                  SizedBox(width: 16,),
                ],
              ),
            ), // 16
            Divider(
              color: colorDevider,
              thickness: 1,
            ),
            if (indexOfScreen == 0) Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight) - 36 - 28 - 12 - 16 - 1 - 16,
              child: SingleChildScrollView(child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ProductScrollImageWidget(listOfImages: mapOfProduct["listOfImages"], function: changeImageIndex, indexOfImage: indexOfImage, size: 300, itsSmallWidget: false, indexOfProduct: 0 ),
                      ],
                    ),
                    SizedBox(height: 24,),
                    Container(
                      width: double.infinity,
                      child: Text(mapOfProduct["title"] , style: TextStyle(
                        color: Color.fromRGBO(52, 64, 84, 0.8),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (mapOfProduct["discount"] != 0) Text(
                            costWithSpaces((mapOfProduct["countOfTowar"] == 0 ? mapOfProduct["price"][mapOfProduct["сhoosenCormMassIndex"]] : mapOfProduct["price"][mapOfProduct["сhoosenCormMassIndex"]] * mapOfProduct["countOfTowar"]  as int).toDouble()),
                            style: TextStyle(
                                color: colorGrey3,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.lineThrough
                            )
                        ),
                        if (mapOfProduct["discount"] != 0) SizedBox(width: 12,),
                        Text(
                          costWithSpaces((mapOfProduct["countOfTowar"] == 0 ? mapOfProduct["price"][mapOfProduct["сhoosenCormMassIndex"]] : mapOfProduct["price"][mapOfProduct["сhoosenCormMassIndex"]] * mapOfProduct["countOfTowar"]) * (1 - mapOfProduct["discount"]/100)),
                          style: textStyleB3,
                        ),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        chooseCormMassWidget(
                          index: mapOfProduct["сhoosenCormMassIndex"],
                          whenActiveIndex: 0,
                          mass: mapOfProduct["massTypes"][0],
                          function: () {
                            functionChangeCormMassIndex(0);
                          },
                        ),
                        SizedBox(width: 8,),
                        chooseCormMassWidget(
                          index: mapOfProduct["сhoosenCormMassIndex"],
                          whenActiveIndex: 1,
                          mass: mapOfProduct["massTypes"][1],
                          function: () {
                            functionChangeCormMassIndex(1);
                          },
                        ),
                        SizedBox(width: 8,),
                        chooseCormMassWidget(
                          index: mapOfProduct["сhoosenCormMassIndex"],
                          whenActiveIndex: 2,
                          mass: mapOfProduct["massTypes"][2],
                          function: () {
                            functionChangeCormMassIndex(2);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 36,),
                    if (mapOfProduct['countOfTowar'] != 0) Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: colorRed,
                          borderRadius: BorderRadius.circular(12),
                        ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: (){
                                changeCountOfProduct(0);
                              },
                              child: Icon(Icons.remove,size: 24, color: Colors.white,),
                            ),
                            SizedBox(width: 36,),
                            Text("${mapOfProduct['countOfTowar']}", style: TextStyle(
                               color: Colors.white,
                               fontSize: 20,
                               fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 36,),
                            InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: (){
                                changeCountOfProduct(1);
                              },
                              child: Icon(Icons.add,size: 24, color: Colors.white),
                            ),
                        ],
                      ),
                    ),
                    if (mapOfProduct['countOfTowar'] == 0) MyButton(
                        onTap: (){
                          print(mapOfProduct["price"]);
                          print(mapOfProduct["price"][mapOfProduct["сhoosenCormMassIndex"]]);
                          // changeCountOfProduct(1);


                        },
                        text: "В корзину")
                    ,
                    SizedBox(height: 36,),
                  ],
                ),
              ),),
            ),
            if (indexOfScreen == 1) Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight) - 36 - 28 - 12 - 16 - 1 - 16,
              child: SingleChildScrollView(
                child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24,),
                    Text("Класс корма", style: textStyleB3,),
                    SizedBox(height: 8,),
                    Text(classOfCorm, style: textStyleL3Grey08,),
                    SizedBox(height: 16,),
                    Text("Тип корма", style: textStyleB3,),
                    SizedBox(height: 8,),
                    Text(typeOfCorm, style: textStyleL3Grey08,),
                    SizedBox(height: 16,),
                    Text("Возраст питомца", style: textStyleB3,),
                    SizedBox(height: 8,),
                    Text(petAge, style: textStyleL3Grey08,),
                    SizedBox(height: 16,),
                    Text("Размер питомца", style: textStyleB3,),
                    SizedBox(height: 8,),
                    Text(mapOfProduct["petSize"], style: textStyleL3Grey08,),
                    SizedBox(height: 16,),
                    Text("Активность питомца", style: textStyleB3,),
                    SizedBox(height: 8,),
                    Text(mapOfProduct["petActivity"], style: textStyleL3Grey08,),
                    SizedBox(height: 16,),
                    Text("Особые потребности", style: textStyleB3,),
                    SizedBox(height: 8,),
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Text(
                              mapOfProduct["specialNeeds"][index], style: textStyleL3Grey08,
                          );
                        },
                        itemCount: mapOfProduct["specialNeeds"].length,
                    ),
                    SizedBox(height: 8,),
                    Text("Ингридиенты", style: textStyleB3,),
                    SizedBox(height: 8,),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Text(
                          mapOfProduct["ingredients"][index], style: textStyleL3Grey08,
                        );
                      },
                      itemCount: mapOfProduct["ingredients"].length,
                    ),
                  ],
                ),
               ),
              ),
            ),
            if (indexOfScreen == 2) Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight) - 36 - 28 - 12 - 16 - 1 - 16,
              child: SingleChildScrollView(child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24,),
                    Text("Обновленный состав", style: textStyleB3,),
                    SizedBox(height: 8,),
                    Text("Ингредиенты:", style: textStyleB3,),
                    SizedBox(height: 8,),
                    Text(mapOfProduct["allIngredients"], style: textStyleL3Grey08,),
                  ],
                ),
              ),),
            ),
            if (indexOfScreen == 3) Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight) - 36 - 28 - 12 - 16 - 1 - 16,
              child: SingleChildScrollView(child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24,),
                    Text("Описание:", style: textStyleB3,),
                    SizedBox(height: 8,),
                    Text(brend["desctiption"], style: textStyleL3Grey08,),
                  ],
                ),
              ),),
            ),
          ],
        ),
      )
    );
  }
}
