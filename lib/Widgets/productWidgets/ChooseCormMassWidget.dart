import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../design.dart';

var kg = "кг";
var gr = "гр";

Widget chooseCormMassWidget ({
  required index,
  required whenActiveIndex,
  required mass,
  required function,

}) {
  return GestureDetector(
    onTap: function,
    child: Container(
        height: 24,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: (whenActiveIndex == index) ? colorOrange : Color.fromRGBO(130, 130, 130, 1), width: 2)
        ),
        child: Row(
          children: [
            SizedBox(width: 8,),
            if (whenActiveIndex == index) SvgPicture.asset("lib/assets/mdi_fire.svg", color: colorOrange),
            if (whenActiveIndex == index) SizedBox(width: 4,),
            Text(
              //"$mass ${inKilograms == true ? kg : gr}",
              "$mass",
              style: TextStyle(
                color: (whenActiveIndex == index) ? colorOrange : Color.fromRGBO(130, 130, 130, 1),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            SizedBox(width: 8,),
          ],
        )
    ),
  );
}