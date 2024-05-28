import 'package:flutter/material.dart';
import 'package:na_dom/Widgets/appAndBottomBars/AppBarWidget.dart';
import 'package:na_dom/Widgets/generalCustomWidgets/CustomButton.dart';
import 'package:na_dom/Widgets/generalCustomWidgets/CustomTextField.dart';
import 'package:na_dom/design.dart';

import '../../Widgets/scaffold_message.dart';

class DeliveryAddressPage extends StatefulWidget {
  final Map address;
  const DeliveryAddressPage({Key? key, required this.address}) : super(key: key);

  @override
  State<DeliveryAddressPage> createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {

  var sityFocusNode = FocusNode();
  var stritHouseFocusNode = FocusNode();
  var podyezdFocusNode = FocusNode();
  var appartmentFocusNode = FocusNode();
  var commentFocusNode = FocusNode();

  var controllerSity = TextEditingController();
  var controllerStritHouse = TextEditingController();
  var controllerPodyezd = TextEditingController();
  var controllerAppartment = TextEditingController();
  var controllerComment = TextEditingController();

  addAdressToTextFields () {
    print(widget.address["city"]);
    if ((widget.address as Map).isNotEmpty) {
      setState(() {
        controllerSity.text = widget.address["city"];
        controllerStritHouse.text = widget.address["street, house"];
        controllerPodyezd.text = widget.address["entrance"];
        controllerAppartment.text = widget.address["apartment"];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addAdressToTextFields();
  }

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
        body: GestureDetector(
          onTap: (){
            sityFocusNode.unfocus();
            stritHouseFocusNode.unfocus();
            podyezdFocusNode.unfocus();
            appartmentFocusNode.unfocus();
            commentFocusNode.unfocus();
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height - (MediaQuery.of(context).padding.top + kToolbarHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 36,),
                      Text("Адрес доставки",style: textStyleB1,),
                      SizedBox(height: 24,),
                      Text("Город",style: textStyleB3Black2,),
                      SizedBox(height: 8,),
                      CustomTextField(
                          controller: controllerSity,
                          focusNode: sityFocusNode,
                          hingText: "Город",
                          obscureText: false,
                        onTextEditionComplete: (){},
                      ),
                      SizedBox(height: 16,),
                      Text("Улица, дом",style: textStyleB3Black2,),
                      SizedBox(height: 8,),
                      CustomTextField(
                          controller: controllerStritHouse,
                          focusNode: stritHouseFocusNode,
                          hingText: "Улица, дом",
                          obscureText: false,
                        onTextEditionComplete: (){},
                      ),
                      SizedBox(height: 16,),
                      Row(
                          children: [
                            Container(
                              width: (MediaQuery.of(context).size.width - 48)/2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Подьезд", style: textStyleB3Black2,),
                                  SizedBox(height: 8,),
                                  CustomTextField(
                                      controller: controllerPodyezd,
                                      focusNode: podyezdFocusNode,
                                      hingText: "Подьезд",
                                      obscureText: false,
                                      onTextEditionComplete: (){},
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
                                  Text("Квартира", style: textStyleB3Black2,),
                                  SizedBox(height: 8,),
                                  CustomTextField(
                                      controller: controllerAppartment,
                                      focusNode: appartmentFocusNode,
                                      hingText: "Квартира",
                                      obscureText: false,
                                      onTextEditionComplete: (){},
                                  )
                                ],
                              ),
                            ),
                          ]
                      ),
                      SizedBox(height: 16,),
                      Text("Комментарий",style: textStyleB3Black2,),
                      SizedBox(height: 8,),
                      CustomTextField(
                          controller: controllerComment,
                          focusNode: commentFocusNode,
                          hingText: "Комментарий",
                          obscureText: false,
                          onTextEditionComplete: (){},
                      ),
                      Spacer(),
                      MyButton(onTap: (){
                        if (controllerSity.text == "" || controllerStritHouse.text == "" || controllerPodyezd.text == "" || controllerAppartment.text == "" ) {
                          ScaffoldMessage(context: context, message: "Заполните адресс полностью");
                        } else {
                          ScaffoldMessage(context: context, message: "Адресс доабвлен");
                          Navigator.pop(context, {
                            "city" : controllerSity.text,
                            "street, house" : controllerStritHouse.text,
                            "entrance" : controllerPodyezd.text,
                            "apartment" : controllerAppartment.text,
                            "comment" : controllerComment.text,
                          }
                          );

                        }
                      }, text: "Сохранить"),
                      SizedBox(height: 36,)
                    ],
                  ),
                ),
              )
            ),
          ),
        )
    );
  }
}
