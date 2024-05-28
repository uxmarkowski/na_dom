import 'package:flutter/material.dart';

import '../../design.dart';

Widget PictureButtonBrand ({required context,required onTap, required imageLink}) {
  return InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: onTap,
    child: Container(
      height: 72,
      width: (MediaQuery.of(context).size.width - 56)/3,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colorGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        height: 46,
        width: 92,
        child: Image.asset(imageLink, fit: BoxFit.fill,),
      ),
    ),
  );
}