import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:na_dom/Widgets/generalCustomWidgets/CustomButton.dart';
import 'package:na_dom/screens/sign/sign_up.dart';

import '../../main.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,

      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 142,),
              Container(
                width: 308,
                height: 224,
                child: Image.asset("lib/assets/welcomeImage.png",fit: BoxFit.fill,),
              ),
              SizedBox(height: 48,),
              Text("Добро", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, )),
              Text("пожаловать!", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, )),
              SizedBox(height: 12,),
              Text("Интернет магазин лучших кормов", style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal,)),
              SizedBox(height: 2,),
              Text("для наших клиентов", style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal,)),
              Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: MyButton(
                    onTap: () {
                      // Navigator.pushNamed(context, '/mainPage');
                      Navigator.pushAndRemoveUntil(
                          context, CustomPageRoute(builder: (context) => const SignUpPage(is_sign_up: false,)),
                          ModalRoute.withName('/signUpPage') // Replace this with your root screen's route name (usually '/')
                      );
                    },
                    text: "Вход"
                ),
              ),
              SizedBox(height: 16,),
              InkWell(
                onTap: (){
                  Navigator.pushAndRemoveUntil(
                      context, CustomPageRoute(builder: (context) => const SignUpPage(is_sign_up: true,)),
                      ModalRoute.withName('/signUpPage') // Replace this with your root screen's route name (usually '/')
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Нет аккаунта?", style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal,)),
                    SizedBox(width: 4,),
                    Text("Зарегистрироваться", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,))

                  ],
                ),
              ),
              SizedBox(height: 48,)
            ],
          ),
        )
      ),
    );
  }
}
