import 'package:flutter/material.dart';

import '../../design.dart';




Widget SelectTheDeliveryDateWidget ({
  required indexActiveWidget,
  required Function(int) function,
  required dates,
  required days,
  required tomorrow,
}) {
  dates as List;
  return Container(
    width: double.infinity,
    height: 72,
    child: ListView.separated(

        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) {
          return SizedBox(width: 12,);
        },
        itemBuilder: (context, index){
          return InkWell(
            onTap: (){
              function(index);
            },
            child: Container(
              margin: (index == 0) ? EdgeInsets.only(left: 12) : null,
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                  color: (indexActiveWidget == index) ? colorRed : Color.fromRGBO(231, 236, 240, 1),
                  borderRadius: BorderRadius.circular(4)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 12,),
                  Text(
                    dates[index],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: (indexActiveWidget == index) ? Colors.white : colorBlack
                   ),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    (dates[index] == tomorrow) ? "Завтра" : days[index],
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: (indexActiveWidget == index) ? Colors.white : colorGrey3
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: dates.length,
    ),
  );
}
