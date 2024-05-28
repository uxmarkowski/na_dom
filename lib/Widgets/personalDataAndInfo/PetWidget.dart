import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../design.dart';


Widget PetWidget ({
  required pet,
  required functionDelete,
  required functionTransition
  }) {
  return InkWell(
    onTap: (){
      functionTransition();
    },
    child: Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color.fromRGBO(243, 246, 249, 1)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
            child: Text(pet, style: textStyleB3Black2,),
          ),
          InkWell(
            onTap: (){
              functionDelete();
            },
            child: Padding(
              padding: EdgeInsets.all(12),
              child: SvgPicture.asset("lib/assets/Delete.svg", color: Color.fromRGBO(79, 79, 79, 1)),
            )
          )
        ],
      )
    ),
  );
}