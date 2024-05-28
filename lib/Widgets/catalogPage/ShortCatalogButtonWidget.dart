import 'package:flutter/material.dart';

import '../../design.dart';

Widget ShortCatalogButtonWIdget ({
  required context,
  required function,
  required text,
  required withColumn,
  required image,
  text2,
}) {
  return InkWell(
    onTap: function,
    child: Container(
      alignment: Alignment.topLeft,
      height: 80,
      width:(MediaQuery.of(context).size.width - 48)/2,
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
              Text(text2, style: textStyleB4)
            ],
          ) : Container(
            alignment: Alignment.topLeft,
            height: 50,
            width: 95,
            child: Text(text, style: textStyleB4,),
          )
      ),
    ),
  );
}