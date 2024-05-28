import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../design.dart';
import '../../screens/catalog/ProductPage.dart';
import '../custom_route.dart';


// Сухой корм для кошек Felix Мясное объедение, с курицей
// скидка 10%
// цена 248 441 2930
// вес 600 гр 1300гр 10кг
// https://ir.ozone.ru/s3/multimedia-h/wc1000/6685463885.jpg
// https://ir.ozone.ru/s3/multimedia-z/wc1000/6708802163.jpg
// https://ir.ozone.ru/s3/multimedia-2/wc1000/6708802166.jpg


// Корм ECATS сухой полнорационный для кошек с говядиной
// скидка 37%
// цена 800 1500 2000
// вес 5кг 10кг 15кг
// https://ir.ozone.ru/s3/multimedia-1-1/wc1000/6968480905.jpg
// https://ir.ozone.ru/s3/multimedia-1-f/wc1000/6968480919.jpg
// https://ir.ozone.ru/s3/multimedia-1-v/wc1000/6968322463.jpg

// Корм EDOGS сухой полнорационный для собак с говядиной
// скидка 21%
// цена 1200 2100 3000
// вес 5кг 10кг 15кг
// https://ir.ozone.ru/s3/multimedia-1-o/wc1000/6968646888.jpg
// https://ir.ozone.ru/s3/multimedia-1-f/wc1000/6968646843.jpg
// https://ir.ozone.ru/s3/multimedia-1-d/wc1000/6968338537.jpg

// AJO Dog Maxi Adult Сухой корм для собак крупных пород, Оленина, Индейка и Гречка
// скидка 33%
// цена 2000 4000 5000
// вес "5кг", " 10кг", "12кг"
// https://ir.ozone.ru/s3/multimedia-q/wc1000/6632512298.jpg
// https://ir.ozone.ru/s3/multimedia-x/wc1000/6632505213.jpg
// https://ir.ozone.ru/s3/multimedia-n/wc1000/6632505239.jpg

// Корм сухой BOWL WOW супер премиум с индейкой, рисом и шпинатом для щенков мелких пород полнорационный, натуральный с высоким содержанием белка для суставов и иммунитета
// скидка 10%
// цена 800, 1824, 3720
// вес "800гр", "2кг", "5кг"
// https://ir.ozone.ru/s3/multimedia-q/wc1000/6733160666.jpg
// https://ir.ozone.ru/s3/multimedia-7/wc1000/6733160683.jpg
//



// Brends
//  "124141423424"
//    {
//      "brendID" : "124141423424"
//      "name" : "Royal canin"
//      "discription" : ""
//    }
//
//  "124141423424"
//    {
//      "brendID" : "124141423424"
//      "name"    : "Sheba"
//    }







Widget TowarInCartWidget ({
  required context,
  required title,
  required mass,
  required price,
  required discount,
  required image,
  required showCounter,
  required index,
  required docID,
  required widgetIsFaworite,
  required canDeleteThisProduct,
  required Function(int, int) functionCnangeCountOfProduct,
  required Function(int) functionChangeFaworite,
  required Function(int) functionDelete,
  required functionTransition,
  required count,
}) {
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
                    spacing: 8.0,
                    children: [
                      Text(
                        title.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: textStyleL4,
                      ),
                      Text(
                        "${mass.toString()}",
                        style: TextStyle(
                          color: colorGrey2,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16,),
                Row(
                  children: [
                    Text("${ ((discount == 0 ? price * count : (price * count)* (1 - discount/100)) as double).round() } ₽", style: textStyleB4,),
                    if (showCounter == true) SizedBox(width: 12,),
                    if (showCounter == true) InkWell(
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
                    if (showCounter == true) SizedBox(width: 12,),
                    if (showCounter == true) Text("$count", style: textStyleB4,),
                    if (showCounter == true) SizedBox(width: 12,),
                    if (showCounter == true) InkWell(
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
                    if (canDeleteThisProduct == true) SizedBox(width: 12,),
                    if (canDeleteThisProduct == true) GestureDetector(
                        onTap: (){
                          functionDelete(index);
                        },
                        child: SvgPicture.asset("lib/assets/Delete.svg", color: Color.fromRGBO(79, 79, 79, 1),)
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      )
  );
}