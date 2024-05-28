import 'package:flutter/material.dart';

import '../../design.dart';

void ScaffoldMessage({required context,required message, color}){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: Duration(seconds: 3),
    backgroundColor: color != null ? color : colorRed,
  ));
}