import 'package:flutter/material.dart';
import 'package:na_dom/Widgets/appAndBottomBars/AppBarWidget.dart';
import 'package:na_dom/Widgets/appAndBottomBars/BottomNavigationBarWidget.dart';
import 'package:na_dom/Widgets/faworiteProducts/FaworiteProductWidget.dart';
import 'package:na_dom/design.dart';

import '../../Widgets/custom_route.dart';
import '../../Widgets/productWidgets/TowarInCartWidget.dart';
import '../../Widgets/hive_metod.dart';
import '../catalog/AllTypesOfCormPage.dart';
import '../catalog/ProductPage.dart';


class FavoriteProductsPage extends StatefulWidget {
  const FavoriteProductsPage({Key? key}) : super(key: key);

  @override
  State<FavoriteProductsPage> createState() => _FavoriteProductsPageState();
}

class _FavoriteProductsPageState extends State<FavoriteProductsPage> {

  List listOfProducts = [];
  var cart = [];

  void functionChangeCormMassIndex (int index, int indexOfObject) {
    setState(() { listOfProducts[indexOfObject]["сhoosenCormMassIndex"] = index; });

    if (cart.where((element) => element["docID"] == listOfProducts[indexOfObject]["docID"]).isNotEmpty) {

      cart.removeWhere((element) => element["docID"] == listOfProducts[indexOfObject]["docID"]);
      cart.add(listOfProducts[indexOfObject]);
      model.saveCart(cart);

    }
    // print("cart affter $cart");

  }

  void changeCountOfProduct (int, indexOfObject) {
    if (int == 1) {
      setState(() { listOfProducts[indexOfObject]["countOfTowar"]++; });
      // добавить
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
        // вычесть
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
  } // if 1 plus if 0 minus

  void changeFaworiteWidget (index) {

    if (listOfProducts.isNotEmpty) ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("faworiteWidget").child(listOfProducts[index]["docID"]).remove();
    setState(() {
      listOfProducts.removeAt(index);
    });

  }

  void getProductsForThisScreenInitState () async {
    var _collection = await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("faworiteWidget").get();
    var collectionChildren = _collection.children.toList();
    listOfProducts.clear();

    collectionChildren.forEach((doc) {
      var data = doc.value as Map;
      listOfProducts.add(data);
    });

    setState(() {
    });
    cart = await model.getCart();

    for (int i = 0; i < listOfProducts.length; i++) {
      if (cart.where((cartProduct) => cartProduct["docID"] == listOfProducts[i]["docID"]).isNotEmpty) {
        var countOfProductInCart = cart.where((element) => element["docID"] == listOfProducts[i]["docID"]).first["countOfTowar"];
        var indexOfCormMassInCart = cart.where((element) => element["docID"] == listOfProducts[i]["docID"]).first["сhoosenCormMassIndex"];

        setState(() {
          listOfProducts[i]["countOfTowar"] = countOfProductInCart;
          listOfProducts[i]["сhoosenCormMassIndex"] = indexOfCormMassInCart;
        });
      } else { // если продукта нет в корзине то число товара равно 0
        setState(() {
          listOfProducts[i]["countOfTowar"] = 0;
          listOfProducts[i]["сhoosenCormMassIndex"] = 0;
        });
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
      bottomNavigationBar: BottomNavigationBarWidget(
          currentBottomBarIndex: 4,
          context: context
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 36,),
              Text("Избранное", style: textStyleB1,),
              SizedBox(height: 24,),
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 24),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return FaworiteProductWidget(
                    context: context,
                    image: listOfProducts[index]["listOfImages"][0],
                    title: listOfProducts[index]["title"],
                    massTypes: listOfProducts[index]["massTypes"],
                    chooseCormMassIndex: listOfProducts[index]["сhoosenCormMassIndex"],
                    price: listOfProducts[index]["price"],
                    discount: listOfProducts[index]["discount"],
                    count: listOfProducts[index]["countOfTowar"],
                    widgetIsFaworite: listOfProducts[index]["widgetIsFaworite"],
                    docID: listOfProducts[index]["docID"],
                    showCounter: true,
                    index: index,
                    functionCnangeCountOfProduct: changeCountOfProduct,
                    functionChangeFaworite: changeFaworiteWidget,
                    functionChangeCormMassIndex: functionChangeCormMassIndex,
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
            ],
          ),
        ),
      ),
    );
  }
}
