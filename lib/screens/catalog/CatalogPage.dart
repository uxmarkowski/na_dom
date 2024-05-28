import 'package:flutter/material.dart';
import 'package:na_dom/Widgets/appAndBottomBars/AppBarWidget.dart';
import 'package:na_dom/Widgets/appAndBottomBars/BottomNavigationBarWidget.dart';
import 'package:na_dom/Widgets/catalogPage/LongCatalogButtonWidget.dart';
import 'package:na_dom/Widgets/catalogPage/ShortCatalogButtonWidget.dart';
import 'package:na_dom/design.dart';
import 'package:na_dom/screens/catalog/AllTypesOfCormPage.dart';
import 'package:na_dom/screens/catalog/JustShopPage.dart';

import '../../Widgets/custom_route.dart';


class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          context: context,
          showSearchIcon: true,
          showContactsIcon: true,
          showPersonalPageIcon: true,
          showFaworiteIcon: false,
          showDeleteIcon: false
      ),
      bottomNavigationBar: BottomNavigationBarWidget(currentBottomBarIndex: 1, context: context),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 36,),
              Text("Каталог",style: textStyleB1,),
              SizedBox(height: 16,),
              LongCatalogButton(
                  context: context,
                  function: (){
                    final page = AllTypesOfCormPage(category: [],);
                    Navigator.of(context).push(CustomPageRoute2(page));
                  },
                  text: "Всё питание", withColumn: true,
                  text2: "в одном месте", secondTextLigth: false,
                  image: "lib/assets/catalogImage1.png"
              ),
              SizedBox(height: 16,),
              LongCatalogButton(
                  context: context,
                  function: (){
                    final page = AllTypesOfCormPage(category: ["1715853282167"],);
                    Navigator.of(context).push(CustomPageRoute2(page));
                  },
                  text: "Сухой корм", withColumn: true, text2: "повседневный", secondTextLigth: true,
                  image: "lib/assets/catalogImage2.png"
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  ShortCatalogButtonWIdget(
                      context: context,
                      function: (){
                        final page = AllTypesOfCormPage(category: ["1715853519958"],);
                        Navigator.of(context).push(CustomPageRoute2(page));
                      },
                      text: "Холистики", withColumn: false,
                      image: "lib/assets/catalogImage3.png"
                  ),

                  SizedBox(width: 16,),
                  ShortCatalogButtonWIdget(
                      context: context,
                      function: (){
                        final page = AllTypesOfCormPage(category: ["1715853479123"],);
                        Navigator.of(context).push(CustomPageRoute2(page));
                      },
                      text: "Лечебные", withColumn: false,
                      image: "lib/assets/catalogImage4.png"
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  ShortCatalogButtonWIdget(
                      context: context,
                      function: (){
                        final page = AllTypesOfCormPage(category: ["1715853505816"],);
                        Navigator.of(context).push(CustomPageRoute2(page));
                      },
                      text: "Гипоалерген-", withColumn: true,
                      text2: "ные",
                      image: "lib/assets/catalogImage5.png"
                  ),
                  SizedBox(width: 16,),
                  ShortCatalogButtonWIdget(context: context,
                      function: (){
                        final page = AllTypesOfCormPage(category: ["1715853538411"],);
                        Navigator.of(context).push(CustomPageRoute2(page));
                      },
                      text: "Витамины",withColumn: true, text2: "и добавки",
                      image: "lib/assets/catalogImage6.png"
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  ShortCatalogButtonWIdget(context: context,
                      function: (){
                        final page = AllTypesOfCormPage(category: ["1715853656851"],);
                        Navigator.of(context).push(CustomPageRoute2(page));
                      },
                      text: "Консервы", withColumn: false,
                      image: "lib/assets/catalogImage7.png"
                  ),
                  SizedBox(width: 16,),
                  ShortCatalogButtonWIdget(context: context,
                      function: (){
                        final page = AllTypesOfCormPage(category: ["1715853670766"],);
                        Navigator.of(context).push(CustomPageRoute2(page));
                      },
                      text: "Лакомства",
                      withColumn: false,
                      image: "lib/assets/catalogImage8.png"
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  ShortCatalogButtonWIdget(context: context,
                      function: (){
                        final page = AllTypesOfCormPage(category: [],);
                        Navigator.of(context).push(CustomPageRoute2(page));
                      },
                      text: "Выгодные", withColumn: true,
                      text2: "цены",
                      image: "lib/assets/catalogImage9.png"
                  ),
                  SizedBox(width: 16,),
                  ShortCatalogButtonWIdget(context: context,
                      function: (){
                        final page = AllTypesOfCormPage(category: ["1715853627662"],);
                        Navigator.of(context).push(CustomPageRoute2(page));
                      },
                      text: "Стерилизо-", withColumn: true,
                      text2: "ванным",
                      image: "lib/assets/catalogImage10.png"

                  ),
                ],
              ),
              SizedBox(height: 56,)
            ],
          ),
        )
      ),
    );
  }
}
