import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:na_dom/design.dart';

import '../../screens/mainScreens/NewsPage.dart';
import '../custom_route.dart';

Widget NewsWidget ({
  required context,
  required title,
  required description,
  required imageLink
}) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: (){
            final page = NewsPage(title: title, description: description, imageLink: imageLink,);
            Navigator.of(context).push(CustomPageRoute2(page));
          },
          child: Stack(
            children: [
              // Container(
              //   width: double.infinity,
              //   height: 140,
              //   alignment: Alignment.center,
              //   child: CupertinoActivityIndicator(),
              // ),
              Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(
                    color: colorGrey,
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: NetworkImage(imageLink),
                        fit: BoxFit.cover
                    )

                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16,),
        Text(title, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12, color: Colors.black),),
        SizedBox(height: 4,),
        Text(
          description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.normal,fontSize: 12, color: Colors.black),
        ),
      ]
  );
}
