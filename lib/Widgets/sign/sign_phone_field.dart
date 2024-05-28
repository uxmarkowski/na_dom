import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


Container SignPhoneFiled({required TextEditingController controller,required node,required icon_name,required hint,}) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08),blurRadius: 10)]
    ),
    padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
    child: TextFormField(
      keyboardType: TextInputType.number,
      controller: controller,
      focusNode: node,
      onTap: (){
        if(controller.text.length==0) {
          controller.text="+";
        }
      },
      onChanged: (value){
        if(controller.text.length==0) {
          controller.text="+";
        }
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