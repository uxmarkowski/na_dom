import 'package:flutter/material.dart';
import 'package:na_dom/screens/catalog/ProductPage.dart';

import '../../design.dart';
import '../custom_route.dart';
import '../../screens/order history/OrderDetailsPage.dart';
import 'ChooseCormMassWidget.dart';
import 'ProductScrollImageWidget.dart';




Widget ProductWidget ({
  required title,
  required discount,
  required price,
  required List masTypes,
  required countOfTowar,
  required listOfImages,
  required docID,

  required context,
  required idexOfObject,
  required indexOfImage,
  required chooseCormMassIndex,
  required transitionFunction,
  //required Function(int) functionTowarInCart,
  required Function(int, int) functionChangeImageIndex,
  required Function(int, int) functionChangeCormMassIndex,
  required Function(int, int) changeCountOfProduct,

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

    String dopElemeng = hundreds < 100 ? "0" : "";
    String secondDopElemeng = hundreds < 10 ? "0" : "";
    String stringHundreds  = (hundreds == 0) ? '' : '${secondDopElemeng}${dopElemeng}${hundreds.toInt()} ';
    String stringThousands = (thousands == 0) ? '' : '${thousands.toInt()} ';

    String finalstringHundreds  = (stringHundreds == '' && thousands != 0) ? '000 ' : stringHundreds;
    String finalstringThousands = (stringThousands == '' && millions != 0) ? '000 ' : stringThousands;

    return "${finalstringThousands}${finalstringHundreds}₽";
  }

  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ProductScrollImageWidget(
        listOfImages: listOfImages,
        function: functionChangeImageIndex,
        indexOfImage: indexOfImage,
        size: 120,
        itsSmallWidget: true,
        indexOfProduct: idexOfObject,
      ),
      SizedBox(width: 16,),
      Container(
        width: MediaQuery.of(context).size.width - 16 - 120 - 16 - 16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                transitionFunction();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 16 - 120 - 16 - 16,
                    child: Text(
                      title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: textStyleL3,
                    ),
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (discount != 0) Text(
                          costWithSpaces(((countOfTowar == 0 ? price[chooseCormMassIndex] : price[chooseCormMassIndex] * countOfTowar) as int).toDouble()),
                          style: TextStyle(
                              color: colorGrey3,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.lineThrough
                          )
                      ),
                      if (discount != 0) SizedBox(width: 12,),
                      Text(
                        costWithSpaces((countOfTowar == 0 ? price[chooseCormMassIndex] : price[chooseCormMassIndex] * countOfTowar) * (1 - discount/100)),
                        style: textStyleB3,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16,),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: List.generate(masTypes.length, (index)  {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    chooseCormMassWidget(
                      index: chooseCormMassIndex,
                      whenActiveIndex: index,
                      mass: masTypes[index],
                      function: () {
                        functionChangeCormMassIndex(index, idexOfObject);
                      },
                    ),
                  ],
                );
              }).toList(),
            ),
            SizedBox(height: 16,),
            if (countOfTowar > 0) Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: (){
                    changeCountOfProduct(0, idexOfObject);
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
                SizedBox(width: 12,),
                Text("$countOfTowar", style: textStyleB4,),
                SizedBox(width: 12,),
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: (){
                    changeCountOfProduct(1, idexOfObject);
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
              ],
            ),
            if (countOfTowar == 0) InkWell(
              onTap: (){
                changeCountOfProduct(1, idexOfObject);
              },
              child: Text("В корзину", style: TextStyle(color: colorRed, fontSize: 16, fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      )
    ],
  );
}