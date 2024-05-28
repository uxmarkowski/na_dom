import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:na_dom/design.dart';



Widget PinCode(NumberController,){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(width: 12,),
      if(NumberController.text.length>=1) ...[
        Container(
          width: 24,
          height: 36,
          child: Center(
              child: Text(NumberController.text.substring(0,1),style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700,color: Colors.black54),)
          ),
        ),
      ] else ...[
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
              color: Color.fromRGBO(232, 233, 235, 1),
              borderRadius: BorderRadius.circular(40)
          ),
        ),
      ],
      if(NumberController.text.length>=2) ...[
        Container(
          width: 24,
          height: 36,
          child: Center(
              child: Text(NumberController.text.substring(1,2),style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700,color: Colors.white),)
          ),
        ),
      ]  else ...[
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
              color: Color.fromRGBO(232, 233, 235, 1),
              borderRadius: BorderRadius.circular(40)
          ),
        ),
      ],
      if(NumberController.text.length>=3) ...[
        Container(
          width: 24,
          height: 36,
          child: Center(
              child: Text(NumberController.text.substring(2,3),style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700,color: Colors.white),)
          ),
        ),
      ] else ...[
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
              color: Color.fromRGBO(232, 233, 235, 1),
              borderRadius: BorderRadius.circular(40)
          ),
        ),
      ],
      if(NumberController.text.length>=4) ...[
        Container(
          width: 24,
          height: 36,
          child: Center(
              child: Text(NumberController.text.substring(3,4),style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700,color: Colors.white),)
          ),
        ),
      ] else ...[
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
              color: Color.fromRGBO(232, 233, 235, 1),
              borderRadius: BorderRadius.circular(40)
          ),
        ),
      ],
      if(NumberController.text.length>=5) ...[
        Container(
          width: 24,
          height: 36,
          child: Center(
              child: Text(NumberController.text.substring(4,5),style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700,color: Colors.white),)
          ),
        ),
      ] else ...[
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
              color: Color.fromRGBO(232, 233, 235, 1),
              borderRadius: BorderRadius.circular(40)
          ),
        ),
      ],
      if(NumberController.text.length>=6) ...[
        Container(
          width: 24,
          height: 36,
          child: Center(
              child: Text(NumberController.text.substring(5,6),style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700,color: Colors.white),)
          ),
        ),
      ] else ...[
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
              color: Color.fromRGBO(232, 233, 235, 1),
              borderRadius: BorderRadius.circular(40)
          ),
        ),
      ],
      SizedBox(width: 12,),
    ],
  );
}