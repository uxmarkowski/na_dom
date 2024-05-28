import 'package:flutter/material.dart';
import 'package:na_dom/design.dart';

import '../../main.dart';

void ScaffoldMessage ({required context,required message}) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
        backgroundColor: colorRed,
      )
  );
}