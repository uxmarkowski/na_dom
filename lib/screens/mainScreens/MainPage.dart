import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:na_dom/Widgets/appAndBottomBars/AppBarWidget.dart';
import 'package:na_dom/Widgets/mainPage/NewsHorizontalLineWidget.dart';
import 'package:na_dom/Widgets/mainPage/NewsWidget.dart';
import 'package:na_dom/Widgets/mainPage/PictureButtonBrand.dart';
import 'package:na_dom/Widgets/mainPage/CardWidget.dart';
import 'package:na_dom/design.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Widgets/appAndBottomBars/BottomNavigationBarWidget.dart';
import '../../Widgets/custom_route.dart';
import '../../Widgets/mainPage/PictureButtonWithUnderLine.dart';
import '../../main.dart';
import '../catalog/AllTypesOfCormPage.dart';
import '../catalog/CatalogPage.dart';
import 'BrendPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int currentBottomBarIndex = 0;

  var searchFocusNode = FocusNode();
  var searchController = TextEditingController();

  List listOfNewsForTopOfScreen = [
    {
      "image" : "lib/assets/firstNewsPicture.png",
      "title" : "Лакомства",
      "desctiption" : "Лакомство - это приятный сюрприз для вашей кошки, но в этом отношении необходимо соблюдать умеренность, иначе кошка очень быстро наберет лишний вес. В качестве лакомств лучше использовать специально предназначенные для этого продукты, выпускаемые с этой целью производителями кормов и пищевых добавок для животных, а не остатки еды со стола и не сырое мясо."

    },
    {
      "image" : "lib/assets/secondNewsPicture.png",
      "title" : "Сбалансированная диета",
      "desctiption" : "Домашние питомцы, как и человек, нуждаются в сбалансированной диете, включающей точно подобранные пропорции питательных веществ. Поэтому лучше всего отдать предпочтение какому-нибудь известному и надежному изготовителю кормов для кошек, чьи продукты включают в себя все необходимое для того, чтобы ваш питомец оставался красивой и здоровой.",

    },
    {
      "image" : "lib/assets/thirdNewsPicture.png",
      "title" : "Сколько корма нужно?",
      "desctiption" : "Это зависит от типа корма, а также от размеров, возраста, физиологического состояния и степени активности домашнего питомца. Соблюдайте ежедневные нормы, указанные на упаковке с кормом, и время от времени взвешивайте кошку.",
    },
  ];
  List listOfNews = [];
  var listOfPets = [];

  void getPetsFromFireBase() async {
    setState(() {
      listOfPets.clear();
    });
    var _collection = await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("userInfo").child("pets").get();
    var collectionChildren = _collection.children.toList();

    collectionChildren.forEach((doc) {
      var data = doc.value as Map;
      setState(() {
        listOfPets.add(data["name"]);
      });
    });
  }
  void getNewsFromFireBase() async {
    var _collection = await ref.child("news").get();
    var collectionChildren = _collection.children.toList();
    listOfNews.clear();

    await Future.forEach(collectionChildren, (doc) {
      var data = doc.value as Map;
      listOfNews.add(data);
    });

    setState(() {});

    sortListOfNews();
  }
  void sortListOfNews () {
  setState(() {
    listOfNews.sort((a, b) => b['newsID'].compareTo(a['newsID']));
  });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPetsFromFireBase();
    getNewsFromFireBase();
  }

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
      bottomNavigationBar: BottomNavigationBarWidget(currentBottomBarIndex: 0, context: context),
      body: GestureDetector(
        onTap: (){
          searchFocusNode.unfocus();
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 24,),
                NewsHorizontalLineWidget(listOfNews: listOfNewsForTopOfScreen),
                SizedBox(height: 24,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Выбор питания для своего питомца", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Colors.black),),
                      SizedBox(height: 16,),
                      Row(
                        children: [
                          PictureButtonWithUnderLine(
                              context: context,
                              text: "Коты",
                              imageLink: "lib/assets/catImage.png",
                              onTap: (){
                                Navigator.pushAndRemoveUntil(
                                    context, CustomPageRoute(builder: (context) => const CatalogPage()),
                                    ModalRoute.withName('/catalogPage') // Replace this with your root screen's route name (usually '/')
                                );
                              }
                          ),
                          SizedBox(width: 16,),
                          PictureButtonWithUnderLine(
                              context: context,
                              text: "Собаки",
                              imageLink: "lib/assets/dogImage.png",
                              onTap: (){
                                Navigator.pushAndRemoveUntil(
                                    context, CustomPageRoute(builder: (context) => const CatalogPage()),
                                    ModalRoute.withName('/catalogPage') // Replace this with your root screen's route name (usually '/')
                                );
                              }
                          )
                        ],
                      ),
                      SizedBox(height: 24,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Топ бренды", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Colors.black),),
                          InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, "/allBrendsPage");
                              },
                              child: Text("Все", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Colors.black),)
                          )
                        ],
                      ),
                      SizedBox(height: 16,),
                      Row(
                        children: [
                          PictureButtonBrand(context: context, onTap: (){
                            final page = BrendPage(brendID: "1715635126659",);
                            Navigator.of(context).push(CustomPageRoute2(page));

                          }, imageLink: "lib/assets/royal_canin.png", ),
                          SizedBox(width: 12,),
                          PictureButtonBrand(context: context, onTap: (){
                            final page = BrendPage(brendID: "1715637019096",);
                            Navigator.of(context).push(CustomPageRoute2(page));

                          }, imageLink: "lib/assets/chappi.png", ),
                          SizedBox(width: 12,),
                          PictureButtonBrand(context: context, onTap: (){
                            final page = BrendPage(brendID: "1715636976901",);
                            Navigator.of(context).push(CustomPageRoute2(page));

                          }, imageLink: "lib/assets/sheba.png", ),
                        ],
                      ),
                      SizedBox(height: 16,),
                      Row(
                        children: [
                          PictureButtonBrand(context: context, onTap: (){
                            final page = BrendPage(brendID: "1715636915698",);
                            Navigator.of(context).push(CustomPageRoute2(page));

                          }, imageLink: "lib/assets/farmina.png", ),
                          SizedBox(width: 12,),
                          PictureButtonBrand(context: context, onTap: (){
                            final page = BrendPage(brendID: "1715636806477",);
                            Navigator.of(context).push(CustomPageRoute2(page));

                          }, imageLink: "lib/assets/kitikat.png", ),
                          SizedBox(width: 12,),
                          PictureButtonBrand(context: context, onTap: (){
                            final page = BrendPage(brendID: "1715636858743",);
                            Navigator.of(context).push(CustomPageRoute2(page));

                          }, imageLink: "lib/assets/winner_miratorg.png", ),
                        ],
                      ),
                      SizedBox(height: 24,),
                      CardWidget(
                          context: context,
                          pets: listOfPets,
                          functionTransition: (){
                            if (listOfPets.isEmpty) Navigator.pushNamed(context, "/aboutThePetPage").then((value) => getPetsFromFireBase());
                          }
                      ),
                      SizedBox(height: 24,),
                      if (listOfNews.length > 0) Text("Новости", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Colors.black),),
                      if (listOfNews.length > 0) SizedBox(height: 16,),
                      if (listOfNews.length > 0) ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return NewsWidget(
                            context: context,
                            title: listOfNews[index]["title"],
                            description: listOfNews[index]["desctiption"],
                            imageLink: listOfNews[index]["image"],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 24,);
                        },
                        itemCount: listOfNews.length,

                      ),
                      SizedBox(height: 48,),
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
