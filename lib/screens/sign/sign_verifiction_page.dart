
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../design.dart';
import '../../main.dart';
import '../../widgets/sign/pin_code.dart';
import '../mainScreens/MainPage.dart';

DatabaseReference db = FirebaseDatabase.instance.ref();

class SignVerificationPage extends StatefulWidget {
  final nomber;
  final name;
  final is_sign_in;
  const SignVerificationPage({Key? key,required this.nomber,required this.name,required this.is_sign_in}) : super(key: key);

  @override
  State<SignVerificationPage> createState() => _SignVerificationPageState();
}

class _SignVerificationPageState extends State<SignVerificationPage> {

  TextEditingController PhoneController=TextEditingController();
  TextEditingController NumberController=TextEditingController();
  FocusNode FocussNode=FocusNode();

  FirebaseAuth _auth = FirebaseAuth.instance;


  String ErroeMessage="";
  String verificationIdd="";

  var RemainTime=60;
  var IsUserExist=false;
  late PhoneAuthCredential Usercredential;

  bool IsCodeTrue=false;
  bool didGetFirstCode=false;
  bool didGetAnotherCode=false;
  bool load_bool=false;



  void SendFirstCode() async{



    await _auth.verifyPhoneNumber(
      phoneNumber: widget.nomber,
      verificationCompleted: (PhoneAuthCredential credential) async{ print("Complete"); },
      verificationFailed: (FirebaseAuthException e) { print(" e "+e.toString()); },
      codeSent: (String verificationId, int? resendToken) async{  print("CodeSent | verificationId: "+verificationId+" | resendToken: "+resendToken.toString());
        String smsCode = NumberController.text; verificationIdd=verificationId; Usercredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
      },
      codeAutoRetrievalTimeout: (String verificationId) {  print('TimeOut');  },
    );

    setState(() {  ErroeMessage="";  didGetAnotherCode=true;  didGetFirstCode=true;  RemainTime=60;  });

    for(int i = 0;i<60;i++) {
      RemainTime=RemainTime-1;
      await Future.delayed(Duration(seconds: 1));
      setState(() { });
    }

    setState(() {  RemainTime=60;  NumberController.clear();  didGetAnotherCode=false;  });

  }

  void GoLogin() async{
    setState(() { load_bool=true;});

    var UsersCollections=await db.child("UsersCollection").get();

    var UsersCollectionsData=(UsersCollections.value as Map==null) ? Map() : UsersCollections.value as Map;
    await Future.forEach(UsersCollectionsData.keys, (users_ids) {if(users_ids==(widget.nomber)) IsUserExist=true;});

    Usercredential = PhoneAuthProvider.credential(smsCode: NumberController.text, verificationId: verificationIdd);

    if(IsUserExist==false) {

      await _auth.signInWithCredential(Usercredential);

      if (_auth.currentUser == null) setState(() {  load_bool=false;  print("Не получилось");});
      else {  print("Получилось");

        await db.child("UsersCollection").child(widget.nomber).set({
          "phone": widget.nomber,
          "name": widget.name,
          "address": "",
        });

        FocussNode.unfocus();
        Navigator.pushAndRemoveUntil(
        context, CustomPageRoute(builder: (context) => const MainPage()),
        ModalRoute.withName('/mainPage')
        );
        //final page = ProfilePage();
        //Navigator.of(context).pushAndRemoveUntil(CustomPageRoute(page),(Route<dynamic> route) => false);
      };

    } else {

      try {
        await _auth.signInWithCredential(Usercredential);
      } on FirebaseAuthException catch (e) {
        print('Failed with error code: ${e.code}');
        print("ee " + e.message.toString());
        setState(() {  ErroeMessage = e.message.toString();  });
        await Future.delayed(Duration(seconds: 5));
        setState(() {  ErroeMessage = "";  });
      }

      if (_auth.currentUser == null) {  print("Не получилось");  setState(() {  load_bool=false;  });  }
      else {
        print("Получилось"); FocussNode.unfocus();

        Navigator.pushAndRemoveUntil(
            context, CustomPageRoute(builder: (context) => const MainPage()),
            ModalRoute.withName('/mainPage')
        );
        //final page = ProfilePage();
        //Navigator.of(context).pushAndRemoveUntil(CustomPageRoute(page),(Route<dynamic> route) => false);
      };

      setState(() {  load_bool=false;  });

    }
  }

  @override
  void initState() {
    SendFirstCode();

    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAppBarBackround,
      appBar: AppBar(
        backgroundColor: colorAppBarBackround,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: (){  FocussNode.unfocus();  },
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 100),
                        Text("Введите смс-код",style: textStyleB1,),
                        SizedBox(height: 8,),
                        Center(child: Text(ErroeMessage.length==0 ? "Мы отправили смс на номер "+widget.nomber : ErroeMessage,textAlign: TextAlign.center,style: TextStyle(height: 1.4,color: ErroeMessage.length==0 ? colorBlack : Colors.red),)),
                        SizedBox(height: 24,),
                        Container(
                          height: 56,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Container(padding: EdgeInsets.only(top: NumberController.text.length>=1 ?  0:6), child: PinCode(NumberController)),
                              Container(
                                color: Colors.red.withOpacity(0),
                                child: Opacity(
                                  child: TextFormField(
                                      controller: NumberController,
                                      keyboardType: TextInputType.number,
                                      autofocus: true,  maxLength: 6,  focusNode: FocussNode,
                                      onChanged: (value){
                                        setState(() { });
                                        if(NumberController.text.length==6) GoLogin();
                                      }
                                  ), opacity: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(margin: EdgeInsets.only(bottom: 24),child: TextButton(onPressed: (){if(RemainTime==60) SendFirstCode();}, child: RemainTime==60 ? Text("Запросить новый код",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),) : Text( "Подождите "+RemainTime.toString(),style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 16),))),
            ),
          ],
        ),

      ),
    );
  }
}
