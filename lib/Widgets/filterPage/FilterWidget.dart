import 'package:flutter/material.dart';

import '../../design.dart';

Widget FilterWidget ({
  required context,
  required index,
  required InsideActiveIndex,
  required widgetIsLong,
  required text,
  required count,
  required function,
}) {
  return InkWell(
    onTap: function,
    child: Container(
      height: 44,
      width: widgetIsLong == true ? (MediaQuery.of(context).size.width - 12 - 32) : (MediaQuery.of(context).size.width - 12 - 32)/2,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: (InsideActiveIndex == index) ? colorGreyFilter : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: (InsideActiveIndex == index) ? null : Border.all(color: colorBorderTextField, width: 1)
      ),
      child: Text(
        "$text ($count)",
        style: TextStyle(
          color: (InsideActiveIndex == index) ? Colors.white : Color.fromRGBO(102, 112, 133, 1),
          fontWeight: (InsideActiveIndex == index) ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
      ),
    ),
  );
}