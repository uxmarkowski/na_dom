import 'package:flutter/material.dart';
import '../../design.dart';

Widget LongCatalogCategoryButton ({
  required context,
  required function,
  required text,
  description,
}) {
  return InkWell(
    onTap: function,
    child: Container(
      alignment: Alignment.centerLeft,
      //height: 80,
      width:MediaQuery.of(context).size.width - 32,
      decoration: BoxDecoration(
        color: colorGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
          padding: EdgeInsets.only(top: 16,left: 16, bottom: 16),
          child: description != null ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(text, style: textStyleB4,),
              // SizedBox(height: 4,),
              Text(description, style: TextStyle(color: Color.fromRGBO(85, 85, 85, 1), fontWeight: FontWeight.normal, fontSize: 12))
            ],
          ) : Container(
            alignment: Alignment.topLeft,
            width: 140,
            child: Text(text, style: textStyleB4,),
          )
      ),
    ),
  );
}