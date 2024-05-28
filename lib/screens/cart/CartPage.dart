import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:na_dom/Widgets/appAndBottomBars/AppBarWidget.dart';
import 'package:na_dom/Widgets/appAndBottomBars/BottomNavigationBarWidget.dart';
import 'package:na_dom/Widgets/productWidgets/TowarInCartWidget.dart';
import 'package:na_dom/Widgets/hive_metod.dart';
import 'package:na_dom/design.dart';

import '../../Widgets/custom_route.dart';
import '../../Widgets/generalCustomWidgets/CustomButton.dart';
import 'package:na_dom/screens/catalog/AllTypesOfCormPage.dart';

import '../catalog/ProductPage.dart';



class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  final GlobalKey _listKey = GlobalKey();
  var heightOfList = 0.0;

  List listOfProducts = [];
  List cart = [];





  void changeCountOfProduct1 (incrementCount, indexOfObject) async {
    setState(() {
      cart[indexOfObject]["countOfTowar"]=cart[indexOfObject]["countOfTowar"]+((incrementCount == 1) ? 1 : (-1));
      cart[indexOfObject]["countOfTowar"] = max(0, cart[indexOfObject]["countOfTowar"] as int); // сделать ему ограничение внизу до 0
    });
    if(cart[indexOfObject]["countOfTowar"]==0) {
      var _widgetIsFaworite = cart[indexOfObject]["widgetIsFaworite"];
      var _docID = cart[indexOfObject]["docID"];
      setState(() {
        cart.removeWhere((element) => element['docID']==cart[indexOfObject]["docID"]); // удалить жлемент из корзины
      });
      if (_widgetIsFaworite == true) {
        print("число товара в избранном продукте изменено");
        await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("faworiteWidget").child(_docID).update({
          "countOfTowar" : 0,
        }); // изменить число продукта в файр бейс на ноль
      }
    }
    model.saveCart(cart);
  } // if incrementCount == 1 plus if incrementCount == 0 minus
  void getProductsForThisScreenInitState1 () async {

    var _collection = await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("faworiteWidget").get();
    var collectionChildren = _collection.children.toList();
    // if(collectionChildren.isEmpty) {
    //
    //   for (int i = 0; i <cart.length; i++) {
    //     setState(() {
    //       cart[i]["widgetIsFaworite"] = false;
    //     });
    //   }
    //
    // } else {
    //
    //   for (int i = 0; i < listOfProducts.length; i++) {
    //     if (cart.where((cartProduct) => cartProduct["docID"] == listOfProducts[i]["docID"]).isNotEmpty) {
    //
    //       setState(() {
    //         cart.where((element) => element["docID"] == listOfProducts[i]["docID"]).first["widgetIsFaworite"] = listOfProducts[i]["widgetIsFaworite"];
    //       });
    //     }
    //   }
    //
    // }
    // изменить иконку избранного если этот товар там уже есть
    print("collectionChildren ${collectionChildren.toString()}");
    await Future.forEach(collectionChildren, (element) {
      print(element.value.toString() );
    });
    await Future.forEach(cart, (product) {
      if (collectionChildren.where((favoriteProduct) => (favoriteProduct.value as Map)["docID"] == product["docID"]).isNotEmpty) {
        setState(() {
          cart.where((element) => element["docID"] == product["docID"]).first["widgetIsFaworite"] = true;
        });
      }
    });
    setState(() {});
  }
  void changeWidgetFavorite1(indexOfObject) async{
    setState(() {
      cart[indexOfObject]["widgetIsFaworite"] =! cart[indexOfObject]["widgetIsFaworite"];
    });
    if (cart[indexOfObject]["widgetIsFaworite"] == true) {
      // добавить в файр бейс
      await ref.child("UsersCollection").
                child(auth.currentUser!.phoneNumber.toString()).
                child("faworiteWidget").
                child(cart[indexOfObject]["docID"]).set(
          {
            "price"  : cart[indexOfObject]["price"],
            "discount"  : cart[indexOfObject]["discount"],
            "title"  : cart[indexOfObject]["title"],
            "massTypes"  : cart[indexOfObject]["massTypes"],
            "сhoosenCormMassIndex" : cart[indexOfObject]["сhoosenCormMassIndex"],
            "docID"  : cart[indexOfObject]["docID"],
            "listOfImages"  : cart[indexOfObject]["listOfImages"],
            "countOfTowar"  : cart[indexOfObject]["countOfTowar"],
            "widgetIsFaworite"  : cart[indexOfObject]["widgetIsFaworite"],
          }
      );
    }
    if (cart[indexOfObject]["widgetIsFaworite"] == false) {
      // удалить из файр бейс
      await ref.child("UsersCollection").
                child(auth.currentUser!.phoneNumber.toString()).
                child("faworiteWidget").
                child(cart[indexOfObject]["docID"]).remove();
    }
    model.saveCart(cart);
  }
  loadCart1() async{
    cart = await model.getCart();
    await Future.forEach(cart, (element) {
      element["widgetIsFaworite"] = false;
    });
    // print("cart "+cart.toString());
    setState(() { });
  }



  void fuctionDelete (index) {
    setState(() {
      cart.removeAt(index);
      listOfProducts.removeAt(index);
    });
    model.saveCart(cart);
    setState(() {
    });
  }
  void getProductsForThisScreenInitState () async {
    var _collectionFavorite = await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("faworiteWidget").get();
    var collectionFavoriteChildren = _collectionFavorite.children.toList();
    listOfProducts.clear();
    cart = await model.getCart();

    // подгрузить продукты из хайва
    await Future.forEach(cart, (element) {
      listOfProducts.add(element);
      element as Map;

    });

    // сделать по стандарту во все товары не избранными
    await Future.forEach(listOfProducts, (element) {
      element["widgetIsFaworite"] = false;
    });

    // подгрузить из fire base фаворит виджеты
    await Future.forEach(listOfProducts, (product) {
      if (collectionFavoriteChildren.where((favoriteProduct) => (favoriteProduct.value as Map)["docID"] == product["docID"]).isNotEmpty) {
        setState(() {
          listOfProducts.where((element) => element["docID"] == product["docID"]).first["widgetIsFaworite"] = true;
        });
      }
    });
    setState(() {});
  }
  void changeWidgetFavorite(indexOfObject) async {

    setState(() {
      listOfProducts[indexOfObject]["widgetIsFaworite"] =! listOfProducts[indexOfObject]["widgetIsFaworite"];
    });

    if (listOfProducts[indexOfObject]["widgetIsFaworite"] == true) {
      // добавить в файр бейс
      await ref.child("UsersCollection").
      child(auth.currentUser!.phoneNumber.toString()).
      child("faworiteWidget").
      child(cart[indexOfObject]["docID"]).set(
          {
            "price"  : cart[indexOfObject]["price"],
            "discount"  : cart[indexOfObject]["discount"],
            "title"  : cart[indexOfObject]["title"],
            "massTypes"  : cart[indexOfObject]["massTypes"],
            "сhoosenCormMassIndex" : cart[indexOfObject]["сhoosenCormMassIndex"],
            "docID"  : cart[indexOfObject]["docID"],
            "listOfImages"  : cart[indexOfObject]["listOfImages"],
            "countOfTowar"  : cart[indexOfObject]["countOfTowar"],
            "widgetIsFaworite"  : cart[indexOfObject]["widgetIsFaworite"],
          }
      );
    }
    if (listOfProducts[indexOfObject]["widgetIsFaworite"] == false) {
      // удалить из файр бейс
      await ref.child("UsersCollection").
      child(auth.currentUser!.phoneNumber.toString()).
      child("faworiteWidget").
      child(cart[indexOfObject]["docID"]).remove();
    }
  }
  void changeCountOfProduct (incrementCount, indexOfObject) async{

    // изменить число товаров в корзине в товарах на экране
    setState(() {
      cart[indexOfObject]["countOfTowar"]=cart[indexOfObject]["countOfTowar"]+((incrementCount == 1) ? 1 : (-1));
      cart[indexOfObject]["countOfTowar"] = max(0, cart[indexOfObject]["countOfTowar"] as int); // сделать ему ограничение внизу до 0
    });

    // удалить из корзины / поставить число товаров в фаворит виджетах на 0
    if(listOfProducts[indexOfObject]["countOfTowar"]==0) {
      var _widgetIsFaworite = listOfProducts[indexOfObject]["widgetIsFaworite"];
      var _docID = listOfProducts[indexOfObject]["docID"]; // изменить место где удаляется товар
      setState(() {
        cart.removeWhere((element) => element['docID']==cart[indexOfObject]["docID"]); // удалить жлемент из корзины
        listOfProducts.removeAt(indexOfObject);
      });
      if (_widgetIsFaworite == true) {
        print("число товара в избранном продукте изменено");
        await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("faworiteWidget").child(_docID).update({
          "countOfTowar" : 0,
        }); // изменить число продукта в файр бейс на ноль
      }
    }





  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductsForThisScreenInitState();

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
      bottomNavigationBar: BottomNavigationBarWidget(currentBottomBarIndex: 3, context: context),
      body: SizedBox(
        height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight) - 82 ,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 36,),
                Text('Корзина',style: textStyleB1,),
                SizedBox(height: 24,),
                ListView.separated(
                  key: _listKey,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return TowarInCartWidget(
                      context: context,
                      image: listOfProducts[index]["listOfImages"][0],
                      title: listOfProducts[index]["title"],
                      mass: listOfProducts[index]["massTypes"][ listOfProducts[index]["сhoosenCormMassIndex"] ],
                      price: listOfProducts[index]["price"][ listOfProducts[index]["сhoosenCormMassIndex"] ],
                      discount: listOfProducts[index]["discount"],
                      count: listOfProducts[index]["countOfTowar"],
                      docID: listOfProducts[index]["docID"],
                      widgetIsFaworite: listOfProducts[index]["widgetIsFaworite"],
                      showCounter: true,
                      index: index,
                      functionCnangeCountOfProduct: changeCountOfProduct,
                      functionChangeFaworite: changeWidgetFavorite,
                      functionDelete: fuctionDelete,
                      canDeleteThisProduct: true,
                      functionTransition: () {
                        final page = ProductPage(docID: listOfProducts[index]["docID"]);
                        Navigator.of(context).push(CustomPageRoute2(page)).then((value) {
                          getProductsForThisScreenInitState();
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
                SizedBox(height: 36,),
                if (cart.isNotEmpty ) MyButton(
                    onTap: (){
                      Navigator.pushNamed(context, '/placingAnOrderPage');
                      // print(heightOfList);
                      // print(controller.position.maxScrollExtent);
                    },
                    text: "Перейти к оформлению"
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
