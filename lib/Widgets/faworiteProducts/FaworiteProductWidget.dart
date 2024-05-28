import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../design.dart';
import '../../screens/catalog/ProductPage.dart';
import '../custom_route.dart';
import '../productWidgets/ChooseCormMassWidget.dart';



Widget FaworiteProductWidget ({
  required context,
  required title,
  required count,
  required massTypes,
  required discount,
  required price,
  required image,
  required index,
  required docID,

  // bool
  required showCounter,
  required widgetIsFaworite,
  required chooseCormMassIndex,

  // functions
  required Function(int, int) functionCnangeCountOfProduct,
  required Function(int) functionChangeFaworite,
  required Function(int, int) functionChangeCormMassIndex,
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
        // crossAxisAlignment: CrossAxisAlignment.start,
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
                      // SizedBox(width: 16,),
                      // Text(
                      //   "${massTypes[chooseCormMassIndex].toString()}",
                      //   style: TextStyle(
                      //     color: colorGrey2,
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.normal,
                      //   ),
                      // )
                    ],
                  ),
                ),
                if (count != 0) SizedBox(height: 16,),
                if (count != 0) Row(
                  children: [
                    chooseCormMassWidget(
                      index: chooseCormMassIndex,
                      whenActiveIndex: 0,
                      mass: massTypes[0],
                      function: () {
                        functionChangeCormMassIndex(0, index);
                      },
                    ),
                    SizedBox(width: 8,),
                    chooseCormMassWidget(
                      index: chooseCormMassIndex,
                      whenActiveIndex: 1,
                      mass: massTypes[1],
                      function: () {
                        functionChangeCormMassIndex(1, index);
                      },
                    ),
                    SizedBox(width: 8,),
                    chooseCormMassWidget(
                      index: chooseCormMassIndex,
                      whenActiveIndex: 2,
                      mass: massTypes[2],
                      function: () {
                        functionChangeCormMassIndex(2, index);
                      },
                    ),
                  ],
                ),
                SizedBox(height: count == 0 ? 8 : 16,),
                if (count == 0) Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (discount != 0) Text(
                        costWithSpaces(((count == 0 ? price[chooseCormMassIndex] : price[chooseCormMassIndex] * count) as int).toDouble()),
                        style: TextStyle(
                            color: colorGrey3,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.lineThrough
                        )
                    ),
                    if (discount != 0) SizedBox(width: 12,),
                    Text(
                      costWithSpaces((count == 0 ? price[chooseCormMassIndex] : price[chooseCormMassIndex] * count) * (1 - discount/100)),
                      style: textStyleB3,
                    ),
                  ],
                ),
                if (count == 0)SizedBox(height: 8,),
                Row(
                  children: [
                    if (count == 0) InkWell(
                      onTap: (){
                        functionCnangeCountOfProduct(1, index);
                      },
                      child: Text("В корзину", style: TextStyle(color: colorRed, fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    if (count != 0)Text("${ ((discount == 0 ? price[chooseCormMassIndex] * count : (price[chooseCormMassIndex] * count)* (1 - discount/100)) as double).round() } ₽", style: textStyleB4,),
                    if (count != 0) SizedBox(width: 12,),
                    if (count != 0) InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: (){
                        functionCnangeCountOfProduct(0, index);
                      },
                      child: Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(242, 242, 242, 1),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Icon(Icons.remove,size: 16,),
                      ),
                    ),
                    if (count != 0) SizedBox(width: 12,),
                    if (count != 0) Text("$count", style: textStyleB4,),
                    if (count != 0) SizedBox(width: 12,),
                    if (count != 0) InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: (){
                        functionCnangeCountOfProduct(1, index);
                      },
                      child: Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(242, 242, 242, 1),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Icon(Icons.add,size: 16,),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: (){
                          functionChangeFaworite(index);
                        },
                        child: widgetIsFaworite ? SvgPicture.asset("lib/assets/Heart2.svg", color: colorRed) : SvgPicture.asset("lib/assets/Heart.svg", color: Color.fromRGBO(79, 79, 79, 1))
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      )
  );
}