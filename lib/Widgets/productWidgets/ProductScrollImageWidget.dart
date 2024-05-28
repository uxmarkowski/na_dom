import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../design.dart';


Widget ProductScrollImageWidget ({
  required listOfImages,
  required Function(int, int) function,
  required indexOfImage,
  required int size,
  required itsSmallWidget,
  required indexOfProduct
}) {

  return Column(
    children: [
      Container(
          height: size.toDouble(),
          width: size.toDouble(),
          child: CarouselSlider(
            items: [
              Image.network(listOfImages[0], fit: BoxFit.fill,),
              Image.network(listOfImages[1], fit: BoxFit.fill,),
              Image.network(listOfImages[2], fit: BoxFit.fill,),
            ],
            options: CarouselOptions(
                aspectRatio: 1/1,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  function(index, indexOfProduct);
                }
            ),
          )
      ),
      SizedBox(height: itsSmallWidget == true ? 4 : 8,),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: itsSmallWidget == true ? 4 : 8,
            height: itsSmallWidget == true ? 4 : 8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(indexOfImage == 0 ? 5 : 4),
                color: indexOfImage == 0 ? Color.fromRGBO(48, 62, 124, 1) : colorGrey1
            ),
          ),
          SizedBox(width: itsSmallWidget == true ? 4 : 12,),
          Container(
            width: itsSmallWidget == true ? 4 : 8,
            height: itsSmallWidget == true ? 4 : 8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(indexOfImage == 1 ? 5 : 4),
                color: indexOfImage == 1 ? Color.fromRGBO(48, 62, 124, 1) : colorGrey1
            ),
          ),
          SizedBox(width: itsSmallWidget == true ? 4 : 12,),
          Container(
            width: itsSmallWidget == true ? 4 : 8,
            height: itsSmallWidget == true ? 4 : 8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(indexOfImage == 2 ? 5 : 4),
                color: indexOfImage == 2 ? Color.fromRGBO(48, 62, 124, 1) : colorGrey1
            ),
          ),
        ],
      ),
    ],
  );
}