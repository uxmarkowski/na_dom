import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:na_dom/Widgets/appAndBottomBars/AppBarWidget.dart';
import 'package:na_dom/design.dart';

import '../../Widgets/custom_route.dart';
import '../../Widgets/hive_metod.dart';
import '../../Widgets/productWidgets/ProductWidget.dart';
import '../catalog/AllTypesOfCormPage.dart';
import '../catalog/ProductPage.dart';


class BrendPage extends StatefulWidget {
  final String brendID;
  const BrendPage({Key? key, required this.brendID}) : super(key: key);

  @override
  State<BrendPage> createState() => _BrendPageState();
}

class _BrendPageState extends State<BrendPage> {

  var indexOfImage = 0;

  void functionTowarInCart2 (indexOfObject) {
    setState(() {
      listOfProducts[indexOfObject]["towarInCart"] = true;
    });
  }
  void functionChangeCormMassIndex2 (int index, int indexOfObject) {
    setState(() {
      listOfProducts[indexOfObject]["сhoosenCormMassIndex"] = index;
    });
  }
  void changeImageIndex2 (int index, int i) {
    setState(() {
      indexOfImage = index;
    });
  }
  void changeCountOfProduct2 (int, indexOfObject) {
    if (int == 1) {
      setState(() {
        listOfProducts[indexOfObject]["productCount"]++;
      });
    } else {
      if (listOfProducts[indexOfObject]["productCount"] > 0) {
        setState(() {
          listOfProducts[indexOfObject]["productCount"]--;
        });
      } if (listOfProducts[indexOfObject]["productCount"] == 0) {
        listOfProducts[indexOfObject]["towarInCart"] = false;
        listOfProducts[indexOfObject]["productCount"] = 1;
      }

    }
  }

  List listOfProducts = [];
  var cart = [];
  Map brend = {};
  var showAllText = false;

  var searchFoucesNode = FocusNode();
  var searchController = TextEditingController();

  void functionChangeCormMassIndex (int index, int indexOfObject) {
    setState(() { listOfProducts[indexOfObject]["сhoosenCormMassIndex"] = index; });

    if (cart.where((element) => element["docID"] == listOfProducts[indexOfObject]["docID"]).isNotEmpty) {

      cart.removeWhere((element) => element["docID"] == listOfProducts[indexOfObject]["docID"]);
      cart.add(listOfProducts[indexOfObject]);
      model.saveCart(cart);

    }
    // print("cart affter $cart");

  }
  void changeImageIndex (int imageIndex, int indexOfProduct) {
    setState(() {
      listOfProducts[indexOfProduct]["imageIndex"] = imageIndex;
    });
  }
  void changeCountOfProduct (int, indexOfObject) {
    if (int == 1) {
      setState(() { listOfProducts[indexOfObject]["countOfTowar"]++; });
      // увеличить число продуктов
      if (cart.where((element) => element["docID"] == listOfProducts[indexOfObject]["docID"]).isNotEmpty) {

        cart.removeWhere((element) => element["docID"] == listOfProducts[indexOfObject]["docID"]);
        cart.add(listOfProducts[indexOfObject]);
        model.saveCart(cart);

      } else {
        cart.add(listOfProducts[indexOfObject]);
      }

    } else {
      if (listOfProducts[indexOfObject]["countOfTowar"] > 1) {
        setState(() { listOfProducts[indexOfObject]["countOfTowar"]--; });
        // уменьшить число продуктов
        if (cart.where((element) => element["docID"] == listOfProducts[indexOfObject]["docID"]).isNotEmpty) {

          cart.removeWhere((element) => element["docID"] == listOfProducts[indexOfObject]["docID"]);
          cart.add(listOfProducts[indexOfObject]);
          model.saveCart(cart);

        }
      } else {
        setState(() { listOfProducts[indexOfObject]["countOfTowar"] = 0; });
        // удаляем из корзины

        cart.removeWhere((element) => element["docID"] == listOfProducts[indexOfObject]["docID"]);
      }
    }
    model.saveCart(cart);
    // print("cart affter $cart");
  }

  getBrendAndProductsInitState () async {
    var _collection = await ref.child("brends").get();
    var collectionChildren = _collection.children.toList();

    await Future.forEach(collectionChildren, (doc) {
      var data = doc.value as Map;
      if (data["brendID"] == widget.brendID) { // подгрузить только бренд этой страницы
        brend["title"] = data["title"];
        brend["desctiption"] = data["desctiption"];
        brend["brendID"] = data["brendID"];
      }
    });

    setState(() {});
    getProductsForThisScreen();
  }
  getProductsForThisScreen () async {
    var _collection = await ref.child("products").get();
    var collectionChildren = _collection.children.toList();
    listOfProducts.clear();

    await Future.forEach(collectionChildren, (doc) {
      var data = doc.value as Map;
      if (data["brendID"] == widget.brendID) { // если это товар нужного бренда (бренда этой страницы)
        print("нашёл товар нужного бренда");
        data["сhoosenCormMassIndex"] = 0;
        data["countOfTowar"] = 0;
        data["imageIndex"] = 0;
        listOfProducts.add(data);
      }
    });

    setState(() {});

    cart = await model.getCart();

    // корректировка товаров с данными из корзины (hive)
    for (int i = 0; i < listOfProducts.length; i++) {
      if (cart.where((cartProduct) => cartProduct["docID"] == listOfProducts[i]["docID"]).isNotEmpty) {
        var countOfProductInCart = cart.where((element) => element["docID"] == listOfProducts[i]["docID"]).first["countOfTowar"];
        var indexOfCormMassInCart = cart.where((element) => element["docID"] == listOfProducts[i]["docID"]).first["сhoosenCormMassIndex"];

        setState(() {
          listOfProducts[i]["countOfTowar"] = countOfProductInCart;
          listOfProducts[i]["сhoosenCormMassIndex"] = indexOfCormMassInCart;
        });
      }
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBrendAndProductsInitState();
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
          child: brend.isEmpty ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Загрузка", style: textStyleL4Grey06,),
                  SizedBox(width: 8,),
                  CupertinoActivityIndicator(),
                ],
              )
            ],
          ) : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 36,),
              Text(
                brend["title"],
                style: textStyleB1,
              ),
              SizedBox(height: 12,),
              Stack(
                children: [
                  Text(
                    brend["desctiption"],
                    style: textStyleL3,
                    maxLines: showAllText == false ? 5 : null,
                  ),
                  if (showAllText == false) Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color.fromRGBO(255, 255, 255, 0), Color.fromRGBO(255, 255, 255, 1)]
                        )
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12,),
              if (showAllText == false)InkWell(
                onTap: (){
                  setState(() {
                    showAllText = true;
                  });
                },
                child: Text("Подробнее", style: TextStyle(color: colorRed, fontSize: 16, fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 36,),
              ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return ProductWidget(
                      title: listOfProducts[index]["title"],
                      discount: listOfProducts[index]["discount"] ?? 0,
                      price: listOfProducts[index]["price"],
                      masTypes: listOfProducts[index]["massTypes"],
                      listOfImages: listOfProducts[index]["listOfImages"],
                      chooseCormMassIndex: listOfProducts[index]["сhoosenCormMassIndex"],
                      countOfTowar: listOfProducts[index]["countOfTowar"],
                      docID: listOfProducts[index]["docID"],


                      context: context,
                      idexOfObject: index,
                      indexOfImage: listOfProducts[index]["imageIndex"],
                      functionChangeImageIndex: changeImageIndex,
                      functionChangeCormMassIndex: functionChangeCormMassIndex,
                      changeCountOfProduct: changeCountOfProduct,
                      transitionFunction: (){
                        final page = ProductPage(docID: listOfProducts[index]["docID"]);
                        Navigator.of(context).push(CustomPageRoute2(page)).then((value) => getProductsForThisScreen());
                        incrementPopularity( productID: listOfProducts[index]["docID"]);
                      },
                    );
                  },
                  separatorBuilder: (context, index){
                    return SizedBox(height: 36,);
                  },
                  itemCount: listOfProducts.length
              ),
              SizedBox(height: 36,)
            ],
          ),
        )
      ),
    );
  }
}
