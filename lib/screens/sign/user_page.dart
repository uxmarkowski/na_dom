
  import 'package:flutter/cupertino.dart';
import 'package:na_dom/screens/sign/sign_up.dart';

import '../../Widgets/custom_route.dart';
import '../catalog/AllTypesOfCormPage.dart';

void DeleteAccount(context,) async{

    var result=await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Внимание"),
        content: Text("Это действие навсегда удалит ваш аккаунт, вы уверены?"),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text("Отменить"),

            onPressed: () => Navigator.of(context).pop(false),
          ),
          CupertinoDialogAction(
            child: Text("Да"),
            isDefaultAction: true,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if(result) {

      var Mail=auth.currentUser!.email.toString().substring(0, auth.currentUser!.email.toString().indexOf('@'));
      await ref.child('users/'+Mail).remove();
      auth.currentUser?.delete();

      final page = SignUpPage(is_sign_up: false,);
      Navigator.of(context).pushAndRemoveUntil(CustomPageRoute2(page),(Route<dynamic> route) => false);
    }
  }

  Future<void> LogOut(context,) async {
    var result=await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text("Выход"),
        content: Text("Вы уверены, что хотите выйти?"),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text("Отмена"),

            onPressed: () => Navigator.of(context).pop(false),
          ),
          CupertinoDialogAction(
            child: Text("Да"),
            isDefaultAction: true,
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if(result) {
      await auth.signOut();
      final page = SignUpPage(is_sign_up: false,);
      Navigator.of(context).pushAndRemoveUntil(CustomPageRoute2(page),(Route<dynamic> route) => false);
    }
  }

