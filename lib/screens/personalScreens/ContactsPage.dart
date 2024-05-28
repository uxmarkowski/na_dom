import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:na_dom/design.dart';

import 'package:url_launcher/url_launcher.dart';

// required suplierList,required filters,required developerList,required currentSuplier,required currentDeveloper



Future<void> _makePhoneCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}



ShowFilters({required context,}) async{


  await showCupertinoModalPopup(
    // useRootNavigator: true,
      barrierDismissible: true,
      filter: ImageFilter.blur(sigmaX: 0,sigmaY: 0),
      barrierColor: Colors.black.withOpacity(0.1),
      context: context,
      builder: (BuildContext builder) {

        return StatefulBuilder(
          key: GlobalKey(),
          builder: (context, setState){
            return CupertinoPopupSurface(
              isSurfacePainted: false,
              child: Material(
                color: CupertinoColors.white,
                child: InkWell(
                  onTap: (){

                  },
                  child: Container(
                      height: 360,
                      decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24))
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Контакты", style: textStyleB1,),
                          SizedBox(height: 12,),
                          Text("Выберите удобный способ связи или оставьте свой номер телефона - мы свяжемся с Вами в ближайшее время.", style: textStyleL3,),
                          SizedBox(height: 24,),
                          Row(
                            children: [
                              SvgPicture.asset("lib/assets/ri_whatsapp-fill.svg"),
                              SizedBox(width: 8,),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    _makePhoneCall('tel:+78126794441');
                                  });
                                },
                                child: Text("+7(812)679-44-41", style: textStyleB3,),
                              ),
                            ],
                          ),
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              SvgPicture.asset("lib/assets/ri_whatsapp-fill.svg"),
                              SizedBox(width: 8,),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    _makePhoneCall('tel:+79215555405');
                                  });
                                },
                                child: Text("+7(921)555-54-05", style: textStyleB3,)
                              ),
                            ],
                          ),
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              SvgPicture.asset("lib/assets/ri_whatsapp-fill.svg"),
                              SizedBox(width: 8,),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    _makePhoneCall('tel:+79218082555');
                                  });
                                },
                                child: Text("+7(921)808-25-55", style: textStyleB3,)
                              ),
                            ],
                          ),
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              SvgPicture.asset("lib/assets/basil_viber-solid.svg"),
                              SizedBox(width: 8,),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    _makePhoneCall('tel:+79215555405');
                                  });
                                },
                                child: Text("+7(921)55-55-405", style: textStyleB3,)
                              ),
                            ],
                          ),
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              SvgPicture.asset("lib/assets/clarity_email-solid.svg"),
                              SizedBox(width: 8,),
                              Text("Написать на email", style: textStyleB3,),
                            ],
                          ),
                          SizedBox(height: 36,),

                        ],
                      )
                  ),
                ),
              ),
            );
          },
        );
      }
  ).then((value) {

  });

}

