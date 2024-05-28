import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:na_dom/Widgets/appAndBottomBars/AppBarWidget.dart';
import 'package:na_dom/design.dart';



class NewsPage extends StatefulWidget {
  final String title;
  final String description;
  final String imageLink;
  const NewsPage({Key? key, required this.title, required this.description, required this.imageLink}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          context: context,
          showSearchIcon: true,
          showContactsIcon: true,
          showPersonalPageIcon: true,
          showFaworiteIcon: false,
          showDeleteIcon: false
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 192,
                  alignment: Alignment.center,
                  child: CupertinoActivityIndicator(),
                ),
                Container(
                  width: double.infinity,
                  height: 192,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.imageLink),
                          fit: BoxFit.cover
                      )
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24,),
                  Text(widget.title, style: textStyleB2,),
                  SizedBox(height: 12,),
                  Text(widget.description, style: TextStyle(
                    color: Color.fromRGBO(34, 34, 34, 0.8),
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    height: 1.4,
                  ))
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
