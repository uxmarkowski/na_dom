import 'package:flutter/material.dart';


Widget PictureButtonWithUnderLine ({required context, required text, required imageLink, required onTap}) {
  return InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: onTap,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 115,
          width: (MediaQuery.of(context).size.width - 48)/2,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imageLink)
              ),
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12)
          ),
        ),
        Container(
          height: 28,
          width: (MediaQuery.of(context).size.width - 48)/2,
          decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.3),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)

              )
          ),
          child: Row(
            children: [
              SizedBox(width: 12,),
              Text(text, style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),)
            ],
          ),
        )
      ],
    ),
  );
}