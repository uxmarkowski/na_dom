import 'package:flutter/material.dart';

import '../../design.dart';


Widget UserWidget ({required name, required phoneNumber}) {
  return Row(
    children: [
      Container(
        height: 36,
        width: 36,
        child: Image.asset("lib/assets/ImagePeople.png"),
      ),
      SizedBox(width: 12,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: textStyleB4,),
          SizedBox(height: 4,),
          Text(
            phoneNumber,
            style: TextStyle(
                color: colorGrey3,
                fontWeight: FontWeight.normal,
                fontSize: 12
            ),
          )
        ],
      )
    ],
  );
}