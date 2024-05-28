import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:na_dom/design.dart';
import 'sign_verifiction_page.dart';

import '../../Widgets/generalCustomWidgets/CustomButton.dart';
import '../../Widgets/sign/prifile_field.dart';
import '../../Widgets/sign/scaffold_message.dart';
import '../../Widgets/sign/sign_phone_field.dart';
import '../../main.dart';
// import '../../widgets/custom_route.dart';





class SignUpPage extends StatefulWidget {
  final is_sign_up;
  const SignUpPage({Key? key,required this.is_sign_up}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController NameController=TextEditingController();
  TextEditingController PhoneController=TextEditingController();

  FocusNode NameFocus=FocusNode();
  FocusNode PhoneFocus=FocusNode();

  bool is_account_exist=false;
  bool wait_bool=false;
  bool is_user_exist=false;


  @override
  void initState() {

    is_user_exist=!widget.is_sign_up;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: colorAppBarBackround,
        body: InkWell(
          onTap: (){
            NameFocus.hasFocus ? NameFocus.unfocus() : null;
            PhoneFocus.hasFocus ? PhoneFocus.unfocus() : null;
          },
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 24,right: 24,top: 100),
                    child: Image.asset("lib/assets/welcomeImage.png",fit: BoxFit.fill,),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24,right: 24,bottom: 48),
                    child: Column(
                      children: [
                        SizedBox(height: 48,),
                        Text(!is_account_exist ? "Регистрация" : "Вход в сообщество",style: textStyleB2,),
                        SizedBox(height: 24),
                        if(!is_account_exist) ...[
                          ProfileFiled(controller: NameController,node: NameFocus,icon_name: "User information", hint: "Имя", onchanged: (){}),
                          SizedBox(height: 16),
                        ],
                        SignPhoneFiled(controller: PhoneController,node: PhoneFocus,icon_name: "Phone", hint: "Номер телефона"),
                        SizedBox(height: 16),
                        MyButton(text: !is_account_exist ? "Создать аккаунт" : "Войти",onTap: (){

                          if(NameController.text.length==0&&!is_account_exist) ScaffoldMessage(context: context, message: "Заполните имя");
                          else if(PhoneController.text.length==0) ScaffoldMessage(context: context, message: "Заполните телефон");
                          else {
                            Navigator.pushAndRemoveUntil(
                                context, CustomPageRoute(builder: (context) => SignVerificationPage(nomber: PhoneController.text, name: NameController.text, is_sign_in: is_account_exist)),
                                ModalRoute.withName('/signVerificationPage')
                            );
                          }

                        }),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: (){
                            setState(() { is_account_exist=!is_account_exist; });
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            child: Center(
                                child: Text("Уже есть аккаунт?",style: textStyleB3,)
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
