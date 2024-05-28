import 'package:flutter/material.dart';
import 'package:na_dom/Widgets/appAndBottomBars/AppBarWidget.dart';
import 'package:na_dom/Widgets/mainPage/NewsHorizontalLineWidget.dart';
import 'package:na_dom/design.dart';

import 'package:na_dom/screens/personalScreens/ContactsPage.dart';

import '../../Widgets/appAndBottomBars/BottomNavigationBarWidget.dart';
import '../catalog/AllTypesOfCormPage.dart';
import '../sign/user_page.dart';

class PersonalAccountPage extends StatefulWidget {
  const PersonalAccountPage({Key? key}) : super(key: key);

  @override
  State<PersonalAccountPage> createState() => _PersonalAccountPageState();
}

class _PersonalAccountPageState extends State<PersonalAccountPage> {


  var listOfNevsPictures = [
    "lib/assets/firstNewsPicture.png",
    "lib/assets/secondNewsPicture.png",
    "lib/assets/thirdNewsPicture.png"
  ];
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPetsFromFireBase();
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
      bottomNavigationBar: BottomNavigationBarWidget(currentBottomBarIndex: 0, context: context, canGoAtChoosenPage: true,is_profile_page: true),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 36,),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Личный кабинет", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black)),
              ),
              SizedBox(height: 24,),
              NewsHorizontalLineWidget(listOfNews: listOfNewsForTopOfScreen),
              SizedBox(height: 24,),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/orderHistoryPage');
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text("История заказов", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                        ),
                      ),
                    ),
                    Divider(
                      color: colorDevider,
                      thickness: 1,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, "/myDataPage").then((value) => getPetsFromFireBase());
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text("Мои данные", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                        )
                      ),
                    ),
                    Divider(
                      color: colorDevider,
                      thickness: 1,
                    ),
                    GestureDetector(
                      onTap: (){
                        //Navigator.pushNamed(context, "/aboutThePetPage");
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text("О компании", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                        ),
                      ),
                    ),
                    Divider(
                      color: colorDevider,
                      thickness: 1,
                    ),
                    GestureDetector(
                      onTap: (){
                        ShowFilters(context: context);
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text("Контакты", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                        ),
                      ),
                    ),
                    // Divider(
                    //   color: colorDevider,
                    //   thickness: 1,
                    // ),
                    // GestureDetector(
                    //   onTap: (){
                    //     //Navigator.pushNamed(context, "/deliveryAddressPage");
                    //   },
                    //   child: Container(
                    //     alignment: Alignment.centerLeft,
                    //     width: double.infinity,
                    //     color: Colors.transparent,
                    //     child: Padding(
                    //       padding: EdgeInsets.symmetric(vertical: 12),
                    //       child: Text("Обратная связь", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                    //     ),
                    //   ),
                    // ),
                    Divider(
                      color: colorDevider,
                      thickness: 1,
                    ),
                    GestureDetector(
                      onTap: (){
                        if (listOfPets.isEmpty) Navigator.pushNamed(context, "/aboutThePetPage").then((value) => getPetsFromFireBase());
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text("Скидочная карта", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                        ),
                      ),
                    ),
                    Divider(
                      color: colorDevider,
                      thickness: 1,
                    ),
                    GestureDetector(
                      onTap: (){
                        LogOut(context);
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text("Выйти из аккауна", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                        ),
                      ),
                    ),
                    Divider(
                      color: colorDevider,
                      thickness: 1,
                    ),
                    GestureDetector(
                      onTap: (){
                        DeleteAccount(context);
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Text("Удалить аккаунт", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                        ),
                      ),
                    ),
                    SizedBox(height: 24,),
                  ],
                ),
              )

            ],
          ),
        ),

      ),
    );
  }
}
