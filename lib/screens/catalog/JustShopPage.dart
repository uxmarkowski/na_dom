import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:na_dom/Widgets/appAndBottomBars/AppBarWidget.dart';
import 'package:na_dom/Widgets/appAndBottomBars/BottomNavigationBarWidget.dart';
import 'package:na_dom/Widgets/catalogPage/ShortCatalogCategoryButton.dart';
import 'package:na_dom/design.dart';

import '../../Widgets/productWidgets/ProductWidget.dart';


class JustShopPage extends StatefulWidget {
  final String title;
  JustShopPage({Key? key, required String this.title}) : super(key: key);

  @override
  State<JustShopPage> createState() => _JustShopPageState();
}

class _JustShopPageState extends State<JustShopPage> {

  var indexOfImage = 0;

  void functionTowarInCart (indexOfObject) {
    setState(() {
      listOfProducts[indexOfObject]["towarInCart"] = true;
    });
  }

  void functionChangeCormMassIndex (int index, int indexOfObject) {
    setState(() {
      listOfProducts[indexOfObject]["сhoosenCormMassIndex"] = index;
    });
  }

  void changeImageIndex(int index, int i) {
    setState(() {
      indexOfImage = index;
    });
  }

  void changeCountOfProduct (int, indexOfObject) {
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

  List<Map<String, dynamic>> listOfProducts = [
    {
      "title" : "Grandorf Консервы для кошек Куриная грудка с мясом",
      "discount" : 12146,
      "price" : 1146,
      "сhoosenCormMassIndex" : 0,
      "productCount" : 1,
      "towarInCart" : false,
      "massTypes" : [
        "2 кг",
        "10 гр",
        "150 гр"
      ],
      "listOfImages" : [
        "lib/assets/productImage.png",
        "lib/assets/productImage.png",
        "lib/assets/productImage.png",
      ],
    },
    {
      "title" : "Grandorf Консервы для кошек Куриная грудка с мясом",
      "discount" : 12500,
      "price" : 5412,
      "сhoosenCormMassIndex" : 0,
      "productCount" : 1,
      "towarInCart" : false,
      "massTypes" : [
        "5 кг",
        "3 кг",
        "250 гр"
      ],
      "listOfImages" : [
        "lib/assets/towar1.png",
        "lib/assets/towar2.png",
        "lib/assets/towar3.png",
      ],
    },
    {
      "title" : "Grandorf Консервы для кошек Куриная грудка с мясом",
      "price" : 1146,
      "сhoosenCormMassIndex" : 0,
      "productCount" : 1,
      "towarInCart" : false,
      "massTypes" : [
        "2 кг",
        "300 гр",
        "150 гр"
      ],
      "listOfImages" : [
        "lib/assets/productImage.png",
        "lib/assets/productImage.png",
        "lib/assets/productImage.png",
      ],
    },

  ];

  var finalResult = "По актуальности ↑";
  var indexOfFilterSort = 0;


  var searchFoucesNode = FocusNode();
  var searchController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
          context: context,
          showSearchIcon: false,
          showContactsIcon: true,
          showPersonalPageIcon: true,
          showFaworiteIcon: false,
          showDeleteIcon: false
      ),
      bottomNavigationBar: BottomNavigationBarWidget(currentBottomBarIndex: 1, context: context),
      body: GestureDetector(
        onTap: (){
          searchFoucesNode.unfocus();
        },
        child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 36,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.title, style: textStyleB1,),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, '/filterPage');
                        },
                        child: SvgPicture.asset("lib/assets/Filter.svg"),
                      ),
                    ],
                  ),
                  SizedBox(height: 12,),
                  CupertinoSearchTextField(
                    controller: searchController,
                    focusNode: searchFoucesNode,
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      SvgPicture.asset("lib/assets/Sortdown.svg"),
                      SizedBox(width: 8,),
                      GestureDetector(
                          onTap: (){
                            if(indexOfFilterSort == 3) {
                              indexOfFilterSort = 0;
                            } else {
                              indexOfFilterSort++;
                            }
                            if (indexOfFilterSort == 0) {
                              setState(() {
                                finalResult = "По актуальности ↑";
                              });
                            } else if (indexOfFilterSort == 1) {
                              setState(() {
                                finalResult = "По актуальности ↓";
                              });
                            } else if (indexOfFilterSort == 2) {
                              setState(() {
                                finalResult = "По цене ↑";
                              });
                            } else {
                              setState(() {
                                finalResult = "По цене ↓";
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Text("Сортировка: $finalResult", style: textStyleB3,),
                            ],
                          )
                      )
                    ],
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
                          countOfTowar: listOfProducts[index]["productCount"],
                          docID: listOfProducts[index]["docID"],

                          context: context,
                          idexOfObject: index,
                          indexOfImage: indexOfImage,
                          //functionTowarInCart: functionTowarInCart,
                          functionChangeImageIndex: changeImageIndex,
                          functionChangeCormMassIndex: functionChangeCormMassIndex,
                          changeCountOfProduct: changeCountOfProduct,
                          transitionFunction: null,
                        );
                      },
                      separatorBuilder: (context, index){
                        return SizedBox(height: 36,);
                      },
                      itemCount: listOfProducts.length
                  ),
                  SizedBox(height: 36,),

                ],
              ),
            )
        ),
      ),
    );
  }
}
