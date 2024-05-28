import 'package:flutter/material.dart';
import 'package:na_dom/screens/catalog/JustShopPage.dart';

class CustomPageRoute2<T> extends PageRoute<T> {
  CustomPageRoute2(this.child, );
  @override
  // TODO: implement barrierColor
  Color get barrierColor => Colors.black;

  @override
  String? get barrierLabel => null;



  final Widget child;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);
}

// final page = AddUniversalEditPage(data: Categories[index],);
// Navigator.of(context).push(CustomPageRoute(page));

// final page = RegisterPageAp();
// Navigator.of(context).pushAndRemoveUntil(CustomPageRoute(page),(Route<dynamic> route) => false);