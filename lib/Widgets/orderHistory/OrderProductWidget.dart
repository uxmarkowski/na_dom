import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../design.dart';
import '../../screens/catalog/ProductPage.dart';
import '../custom_route.dart';
import '../productWidgets/ChooseCormMassWidget.dart';



Widget OrderProductWidget ({
  required context,
  required title,
  required price,
  required image,
  required index,
  required count,
  required docID,
  required widgetIsFaworite,
  required functionTransition,
}) {

  double hundreds = 0; // число до тысячи
  double thousands = 0; // количество тысяч
  double millions = 0; // количество миллионов

  String costWithSpaces (cost) {
    num doubleCosts = cost;
    if (cost < 1000) {
      hundreds = cost;
    } else if (cost < 1000000) {
      hundreds = doubleCosts.toDouble() % 1000;
      thousands = (doubleCosts.toDouble() - hundreds) / 1000;
    }

    String stringHundreds  = (hundreds == 0) ? '' : '${hundreds.toInt()} ';
    String stringThousands = (thousands == 0) ? '' : '${thousands.toInt()} ';

    String finalstringHundreds  = (stringHundreds == '' && thousands != 0) ? '000 ' : stringHundreds;
    String finalstringThousands = (stringThousands == '' && millions != 0) ? '000 ' : stringThousands;


    return "${finalstringThousands}${finalstringHundreds}₽";
  }


  return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            width: 80,
            child: Image.network(image),
          ),
          SizedBox(width: 12,),
          Container(
            width: MediaQuery.of(context).size.width - 16 - 80 - 12 - 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 8,),
                InkWell(
                  onTap: (){
                    functionTransition();
                  },
                  child: Wrap(
                    children: [
                      Text(
                        title.toString(),
                        style: textStyleL4,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 12,),
                  ],
                ),
              ],
            ),
          ),
        ],
      )
  );
}