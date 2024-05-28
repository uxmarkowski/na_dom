import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


Container ProfileFiled({required controller,required node,required icon_name,required hint,required onchanged}) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08),blurRadius: 10)]
    ),
    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
    child: TextFormField(
      controller: controller,
      focusNode: node,
      onChanged: (value){

        onchanged();

      },
      maxLines: null,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIconConstraints: BoxConstraints(maxHeight: 24,minWidth: 36,),
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: SvgPicture.asset("lib/assets/icons/light/$icon_name.svg",color: Colors.black.withOpacity(0.75),),
          )
      ),
    ),
  );
}