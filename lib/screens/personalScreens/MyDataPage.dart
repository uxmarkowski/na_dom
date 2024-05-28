import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:na_dom/Widgets/appAndBottomBars/AppBarWidget.dart';
import 'package:na_dom/Widgets/mainPage/CardWidget.dart';
import 'package:na_dom/Widgets/generalCustomWidgets/CustomButton.dart';
import 'package:na_dom/Widgets/generalCustomWidgets/CustomTextField.dart';
import 'package:na_dom/Widgets/personalDataAndInfo/PetWidget.dart';
import 'package:na_dom/design.dart';
import 'package:na_dom/screens/personalScreens/AboutThePetPage.dart';

import '../../Widgets/custom_route.dart';
import '../../Widgets/generalCustomWidgets/CustomDateTextField.dart';
import '../catalog/AllTypesOfCormPage.dart';

class MyDataPage extends StatefulWidget {
  const MyDataPage({Key? key}) : super(key: key);

  @override
  State<MyDataPage> createState() => _MyDataPageState();
}

class _MyDataPageState extends State<MyDataPage> {

  final FIOFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final birthDateFocusNode = FocusNode();
  final addressFocusNode= FocusNode();

  final controllerFIO = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerBirthDate = TextEditingController();
  final controllerAddress = TextEditingController();

  List nameOfPets = [];

  getPetsFromFireBase () async {
    nameOfPets.clear();
    var _collection = await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("userInfo").child("pets").get();
    var collectionChildren = _collection.children.toList();

    collectionChildren.forEach((doc) {
      var data = doc.value as Map;
      setState(() {
        nameOfPets.add(data["name"]);
      });
    });
    setState(() {});
  }

  getPersonalInfoFromFireBase () async {

    var _collection = await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("userInfo").child("personalInfo").get();

    if(_collection.exists) {
      var collectionChildren = _collection.value as Map;

      if (collectionChildren.containsKey("FIO")) controllerFIO.text = collectionChildren["FIO"].toString();
      if (collectionChildren.containsKey("email")) controllerEmail.text = collectionChildren["email"].toString();
      if (collectionChildren.containsKey("dateBirth")) controllerBirthDate.text = collectionChildren["dateBirth"].toString();
      if (collectionChildren.containsKey("adress")) controllerAddress.text = collectionChildren["adress"].toString();
      
    } else {
      print("нет никаких данных");
    }

    // print("FIO: ${controllerFIO.text}");
    // print("email: ${controllerEmail.text}");
    // print("dateBirth: ${controllerBirthDate.text}");
    // print("adress: ${controllerAddress.text}");

  }

  addPersonalInfoToFireBase () async{

    if(controllerFIO.text != "") {
      await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("userInfo").child("personalInfo").update(
          {
            "FIO"  : controllerFIO.text,
          }
      );
      print("add FIO");
    }
    if(controllerEmail.text != "") {
      await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("userInfo").child("personalInfo").update(
          {
            "email"  : controllerEmail.text,
          }
      );
      print("add email");
    }
    if(controllerBirthDate.text != "") {
      await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("userInfo").child("personalInfo").update(
          {
            "dateBirth"   : controllerBirthDate.text,
          }
      );
      print("add dateBirth");
    }
    if(controllerAddress.text != "") {
      await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("userInfo").child("personalInfo").update(
          {
            "adress"    : controllerAddress.text,
          }
      );
      print("add adress");
    }
  }

  deletePetFromFireBase (index) async {
      await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("userInfo").child("pets").child(nameOfPets[index]).remove();
      setState(() {
        nameOfPets.removeAt(index);
      });
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPersonalInfoFromFireBase();
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
      body: GestureDetector(
        onTap: (){
          FIOFocusNode.unfocus();
          emailFocusNode.unfocus();
          birthDateFocusNode.unfocus();
          addressFocusNode.unfocus();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 36,),
                Text("Мои данные", style: textStyleB1,),
                SizedBox(height: 24,),
                Container(
                  height: 142,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorGrey,
                    borderRadius: BorderRadius.circular(24)
                  ),
                  child: Image.asset("lib/assets/myDatePage.png",fit: BoxFit.fill),
                ),
                SizedBox(height: 24,),
                Text("ФИО", style: textStyleB4Black2,),
                SizedBox(height: 8,),
                CustomTextField(
                    controller: controllerFIO,
                    focusNode: FIOFocusNode,
                    hingText: "ФИО",
                    obscureText: false, onTextEditionComplete: (){},),
                SizedBox(height: 16,),
                Text("Электронная почта", style: textStyleB4Black2,),
                SizedBox(height: 8,),
                CustomTextField(
                    controller: controllerEmail,
                    focusNode: emailFocusNode,
                    hingText: "Электронная почта",
                    obscureText: false, onTextEditionComplete: (){},
                ),
                SizedBox(height: 16,),
                Text("Дата рождения", style: textStyleB4Black2,),
                SizedBox(height: 8,),
                CustomDateTextField(
                    controller: controllerBirthDate,
                    focusNode: birthDateFocusNode,
                    hingText: "Дата рождения",
                    obscureText: false
                ),
                SizedBox(height: 16,),
                Text("Адрес", style: textStyleB4Black2,),
                SizedBox(height: 8,),
                CustomTextField(
                    controller: controllerAddress,
                    focusNode: addressFocusNode,
                    hingText: "Адрес",
                    obscureText: false, onTextEditionComplete: (){},
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Мои питомцы", style: textStyleB3Black2,),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, "/aboutThePetPage").then((value) => getPetsFromFireBase());
                      },
                      child: SvgPicture.asset("lib/assets/Plus.svg"),
                    )
                  ],
                ),
                if (nameOfPets.isNotEmpty) SizedBox(height: 12,),
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PetWidget(
                          pet: nameOfPets[index],
                          functionDelete: (){
                            deletePetFromFireBase(index);
                          },
                          functionTransition: (){
                            final page = AboutThePetPage(pet: nameOfPets[index]);
                            Navigator.of(context).push(CustomPageRoute2(page)).then((value) => getPetsFromFireBase());
                          }
                      );
                    },
                    separatorBuilder: (context, index){
                      return SizedBox(height: 12,);
                    },
                    itemCount: nameOfPets.length,
                ),
                SizedBox(height: 24,),
                CardWidget(
                    context: context,
                    pets: nameOfPets,
                    functionTransition: (){
                      if (nameOfPets.isEmpty) Navigator.pushNamed(context, "/aboutThePetPage").then((value) => getPetsFromFireBase());
                    }
                ),
                SizedBox(height: 48,),
                MyButton(onTap: (){
                  // сохранить данные
                  addPersonalInfoToFireBase();
                }, text: "Сохранить"),
                SizedBox(height: 24,)
              ],
            ),
          )
        ),
      ),
    );
  }
}

class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String separator = '.';
    var text = _format(
      newValue.text,
      oldValue.text,
      separator,
    );

    return newValue.copyWith(
      text: text,
      selection: updateCursorPosition(
        oldValue,
        text,
      ),
    );
  }

  String _format(
      String value,
      String oldValue,
      String separator,
      ) {
    var isErasing = value.length < oldValue.length;
    var isComplete = value.length > _maxChars + 2;

    if (!isErasing && isComplete) {
      return oldValue;
    }

    value = value.replaceAll(separator, '');
    final result = <String>[];

    for (int i = 0; i < min(value.length, _maxChars); i++) {
      result.add(value[i]);
      if ((i == 1 || i == 3) && i != value.length - 1) {
        result.add(separator);
      }
    }

    return result.join();
  }

  TextSelection updateCursorPosition(
      TextEditingValue oldValue,
      String text,
      ) {
    var endOffset = max(
      oldValue.text.length - oldValue.selection.end,
      0,
    );

    var selectionEnd = text.length - endOffset;

    return TextSelection.fromPosition(TextPosition(offset: selectionEnd));
  }
}