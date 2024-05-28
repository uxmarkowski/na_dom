import 'package:flutter/material.dart';

import '../../design.dart';

Widget LongCatalogButton ({
  required context,
  required function,
  required text,
  required withColumn,
  required secondTextLigth,
  required image,
  text2,
}) {
  return InkWell(
    onTap: function,
    child: Container(
      alignment: Alignment.topLeft,
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.fill
        ),
        color: colorGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
          padding: EdgeInsets.only(top: 16,left: 16),
          child: withColumn == true ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(text, style: textStyleB4,),
              Text(text2, style: secondTextLigth ? TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontWeight: FontWeight.normal, fontSize: 12) : textStyleB4,)
            ],
          ) : Container(
            height: 50,
            width: 95,
            child: Text(text, style: textStyleB4,),
          )
      )
    ),
  );
}