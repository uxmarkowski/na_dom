import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:na_dom/design.dart';
import 'package:na_dom/screens/mainScreens/NewsPage.dart';

import '../custom_route.dart';

final ScrollController _controller = ScrollController(initialScrollOffset: 274);

Widget NewsHorizontalLineWidget ({
  required List listOfNews,
}) {
  return Container(
    height: 115,
    width: double.infinity,
    child:   ListView.separated(
      controller: _controller,
      padding: EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: (){
            // final page = NewsPage(title: listOfNews[index]["title"], description: listOfNews[index]["desctiption"], imageLink: listOfNews[index]["image"],);
            // Navigator.of(context).push(CustomPageRoute(page));
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    // color: colorGrey,
                    borderRadius: BorderRadius.circular(12),
                ),
                height: 115,
                width: 298,
                child: Image.asset(listOfNews[index]["image"], fit: BoxFit.cover,),
              ),
            ],
          )
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(width: 16,);
      },
      itemCount: listOfNews.length > 3 ? 3 : listOfNews.length,
    ),
  );
}