import 'package:flutter/material.dart';
import 'package:na_dom/Widgets/appAndBottomBars/AppBarWidget.dart';
import 'package:na_dom/Widgets/generalCustomWidgets/CustomButton.dart';
import 'package:na_dom/Widgets/generalCustomWidgets/CustomTextField.dart';
import 'package:na_dom/Widgets/sign/scaffold_message.dart';
import 'package:na_dom/design.dart';

import '../catalog/AllTypesOfCormPage.dart';

class AboutThePetPage extends StatefulWidget {
  final String pet;
  const AboutThePetPage({Key? key, required this.pet}) : super(key: key);

  @override
  State<AboutThePetPage> createState() => _AboutThePetPageState();
}

class _AboutThePetPageState extends State<AboutThePetPage> {

  var nameFoucesNode = FocusNode();
  var typeFoucesNode = FocusNode();
  var sexFoucesNode = FocusNode();
  var massFoucesNode = FocusNode();
  var typeSherstyFoucesNode = FocusNode();
  var illFoucesNode = FocusNode();
  var allergiaFoucesNode = FocusNode();

  var controllerName = TextEditingController();
  var controllerType = TextEditingController();
  var controllerSex = TextEditingController();
  var controllerMass = TextEditingController();
  var controllerTypeShersty = TextEditingController();
  var controllerIll = TextEditingController();
  var controllerAllergia = TextEditingController();

  var petNameForDelete = "";

  deletePetFromFireBase () async {
    if (petNameForDelete != "") {
      await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("userInfo").child("pets").child(widget.pet).remove();
    }
    Navigator.pop(context);

  }

  getPetInfoFromFireBase () async {
    var _petInfo = await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("userInfo").child("pets").child(widget.pet).get();

    if(_petInfo.exists) {
      var data = _petInfo.value as Map;

      if (data.containsKey("name")) controllerName.text = data["name"].toString();
      if (data.containsKey("type")) controllerType.text = data["type"].toString();
      if (data.containsKey("sex")) controllerSex.text = data["sex"].toString();
      if (data.containsKey("mass")) controllerMass.text = data["mass"].toString();
      if (data.containsKey("typeShersty")) controllerTypeShersty.text = data["typeShersty"].toString();
      if (data.containsKey("ill")) controllerIll.text = data["ill"].toString();
      if (data.containsKey("allergia")) controllerAllergia.text = data["allergia"].toString();

      if (data.containsKey("name")) petNameForDelete = data["name"].toString(); // переменная для удаления

    } else {
      print("нет никаких данных");
    }
    
    // если есть наш питомец указан тогда добавляем
    
    // print("name: ${controllerName.text}");
    // print("type: ${controllerType.text}");
    // print("sex: ${controllerSex.text}");
    // print("mass: ${controllerMass.text}");
    // print("typeShersty: ${controllerTypeShersty.text}");
    // print("ill: ${controllerIll.text}");
    // print("allergia: ${controllerAllergia.text}");

  }

  addPetInfoToFireBase () async {

    if(controllerName.text != "") {
      await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("userInfo").child("pets").child(controllerName.text).update(
          {
            "name" : controllerName.text,
          }
      );
      print("add name");
    }
    if(controllerType.text != "") {
      await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("userInfo").child("pets").child(controllerName.text).update(
          {
            "type" : controllerType.text,
          }
      );
      print("add type");
    }
    if(controllerSex.text != "") {
      await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("userInfo").child("pets").child(controllerName.text).update(
          {
            "sex" : controllerSex.text,
          }
      );
      print("add sex");
    }
    if(controllerMass.text != "") {
      await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("userInfo").child("pets").child(controllerName.text).update(
          {
            "mass" : controllerMass.text,
          }
      );
      print("add mass");
    }
    if(controllerTypeShersty.text != "") {
      await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("userInfo").child("pets").child(controllerName.text).update(
          {
            "typeShersty" : controllerTypeShersty.text,
          }
      );
      print("add typeShersty");
    }
    if(controllerIll.text != "") {
      await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("userInfo").child("pets").child(controllerName.text).update(
          {
            "ill" : controllerIll.text,
          }
      );
      print("add ill");
    }
    if(controllerAllergia.text != "") {
      await ref.child("UsersCollection").child(auth.currentUser!.phoneNumber.toString()).child("userInfo").child("pets").child(controllerName.text).update(
          {
            "allergia" : controllerAllergia.text,
          }
      );
      print("add allergia");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPetInfoFromFireBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          context: context,
          showSearchIcon: false,
          showContactsIcon: false,
          showPersonalPageIcon: false,
          showFaworiteIcon: false,
          showDeleteIcon: true,
          functionOfDeleteIcon: (){
            deletePetFromFireBase();
          }
      ),
      body: GestureDetector(
        onTap: (){
          nameFoucesNode.unfocus();
          typeFoucesNode.unfocus();
          sexFoucesNode.unfocus();
          massFoucesNode.unfocus();
          typeSherstyFoucesNode.unfocus();
          illFoucesNode.unfocus();
          allergiaFoucesNode.unfocus();
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 36,),
                  Text("О питомце",style: textStyleB1,),
                  SizedBox(height: 24,),
                  Text("Имя",style: textStyleB3Black2,),
                  SizedBox(height: 8,),
                  CustomTextFieldWithoutFuncions(
                      controller: controllerName,
                      focusNode: nameFoucesNode,
                      hingText: "Имя",
                      obscureText: false,
                  ),
                  SizedBox(height: 16,),
                  Text("Вид",style: textStyleB3Black2,),
                  SizedBox(height: 8,),
                  CustomTextFieldWithoutFuncions(
                      controller: controllerType,
                      focusNode: typeFoucesNode,
                      hingText: "Вид",
                      obscureText: false,
                  ),
                  SizedBox(height: 16,),
                  Row(
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width - 48)/2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Пол", style: textStyleB3Black2,),
                            SizedBox(height: 8,),
                            CustomTextFieldWithoutFuncions(
                                controller: controllerSex,
                                focusNode: sexFoucesNode,
                                hingText: "Пол",
                                obscureText: false,
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 16,),
                      Container(
                        width: (MediaQuery.of(context).size.width - 48)/2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Вес", style: textStyleB3Black2,),
                            SizedBox(height: 8,),
                            CustomTextFieldWithoutFuncions(
                                controller: controllerMass,
                                focusNode: massFoucesNode,
                                hingText: "Вес",
                                obscureText: false,
                            )
                          ],
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 16,),
                  Text("Тип шерсти",style: textStyleB3Black2,),
                  SizedBox(height: 8,),
                  CustomTextFieldWithoutFuncions(
                      controller: controllerTypeShersty,
                      focusNode: typeSherstyFoucesNode,
                      hingText: "Тип шерсти",
                      obscureText: false,
                  ),
                  SizedBox(height: 16,),
                  Text("Хронические заболевания",style: textStyleB3Black2,),
                  SizedBox(height: 8,),
                  CustomTextFieldWithoutFuncions(
                      controller: controllerIll,
                      focusNode: illFoucesNode,
                      hingText: "Заболевания",
                      obscureText: false,
                  ),
                  SizedBox(height: 16,),
                  Text("Аллергии",style: textStyleB3Black2,),
                  SizedBox(height: 8,),
                  CustomTextFieldWithoutFuncions(
                      controller: controllerAllergia,
                      focusNode: allergiaFoucesNode,
                      hingText: "Аллергии",
                      obscureText: false,
                  ),
                  SizedBox(height: 48,),
                  MyButton(onTap: (){
                    if (controllerName.text != "") {
                      addPetInfoToFireBase();
                      ScaffoldMessage(context: context, message: "Данные сохранены", color: Colors.green);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessage(context: context, message: "Введите кличку питомца");
                    }
                  }, text: "Сохранить"),
                  SizedBox(height: 36,)
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
