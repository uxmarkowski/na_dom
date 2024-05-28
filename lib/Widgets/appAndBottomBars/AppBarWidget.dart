import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../design.dart';
import '../../screens/personalScreens/PersonalAccountPage.dart';
import '../../screens/personalScreens/ContactsPage.dart';
// import '../custom_route.dart';
import 'package:na_dom/main.dart';

AppBar AppBarWidget ({
  required context,
  required showSearchIcon,
  required showContactsIcon,
  required showPersonalPageIcon,
  required showFaworiteIcon,
  required showDeleteIcon,
  functionOfDeleteIcon,
  functionOfFaworiteIcon,
  faworiteWidgetIsChoosen,
}) {
  return AppBar(
    backgroundColor: colorAppBarBackround,
    elevation: 1,
    centerTitle: true,
    title: Container(
      height: 20,
      width: 78,
      child: Image.asset("lib/assets/logo.png", fit: BoxFit.fill,),
    ),
    foregroundColor: colorRed,
    actions: [
      if (showSearchIcon == true) IconButton(
        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
        onPressed: (){
          Navigator.pushNamed(context, "/allBrendsPage");
        },
        icon: SvgPicture.asset("lib/assets/Search.svg"),
      ),
      if (showContactsIcon == true) IconButton(
        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
        onPressed: (){
          ShowFilters(context: context);
        },
        icon: SvgPicture.asset("lib/assets/Phone Call Ringing.svg"),
      ),
      if (showPersonalPageIcon == true) IconButton(
        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
        onPressed: (){

          Navigator.pushAndRemoveUntil(
              context, CustomPageRoute(builder: (context) => const PersonalAccountPage()),
              ModalRoute.withName('/personalAccountPage') // Replace this with your root screen's route name (usually '/')
          );
          // Navigator.pushNamed(context, '/personalAccountPage');
        },
        icon: SvgPicture.asset("lib/assets/user.svg"),
      ),
      if (showFaworiteIcon == true) IconButton(
        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
        onPressed: (){
          functionOfFaworiteIcon();
        },
        icon: faworiteWidgetIsChoosen ? SvgPicture.asset("lib/assets/Heart2.svg", color: colorRed) : SvgPicture.asset("lib/assets/Heart.svg", color: Color.fromRGBO(79, 79, 79, 1)),
      ),
      if (showDeleteIcon == true) IconButton(
        visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
        onPressed: (){
          functionOfDeleteIcon();
        },
        icon: SvgPicture.asset("lib/assets/Delete.svg", color: Color.fromRGBO(79, 79, 79, 1),),
      )
    ],
  );
}