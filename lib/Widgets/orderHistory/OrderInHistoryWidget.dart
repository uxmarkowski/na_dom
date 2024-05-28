import 'package:flutter/material.dart';
import 'package:na_dom/screens/order%20history/OrderDetailsPage.dart';
import '../custom_route.dart';

import '../../design.dart';

Widget OrderInHistoryWidget ({
  required price,
  required date,
  required images,
  required status,
  required deliveryStatus,
  required context,
  required order,

}) {

  print(status);

  images as List;
  return Container(
    child: Column(
      children: [
        Row(
          children: [
            Text("$date", style: textStyleB3,),
            Container(
              height: 16,
              width: 8,
              child: VerticalDivider(
                color: Colors.black,
                thickness: 2,
              ),
            ),
            Text("$price ₽", style: textStyleB3,),
          ],
        ),
        SizedBox(height: 8,),
        Row(
          children: [
            Container(
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: (status =="Неоплачен" || status == "Отменён") ? colorRed : ((status == "В обработке" || status == "В пути" ) ? colorOrange : colorGreen))
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (status == "Неоплачен" || status == "Отменён" ) Text(status, style: TextStyle(color: colorRed, fontWeight: FontWeight.normal, fontSize: 12),),
                      if (status == "В обработке" || status == "В пути" ) Text(status, style: TextStyle(color: colorOrange, fontWeight: FontWeight.normal, fontSize: 12),),
                      if (status == "Доставлен" ) Text(status, style: TextStyle(color: colorGreen, fontWeight: FontWeight.normal, fontSize: 12),),
                    ],
                  ),
                )
            ),
            SizedBox(width: 8,),
            Container(
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: colorBlack)
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    deliveryStatus,
                    style: TextStyle(color: colorBlack, fontWeight: FontWeight.normal, fontSize: 12),
                  ),
                )
            )
          ],
        ),
        SizedBox(height: 16,),
        Container(
          width: MediaQuery.of(context).size.width - 32,
          height: 76,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context,index){
              return SizedBox(width: 12,);
            },
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  final page = OrderDetailsPage(order: order,);
                  Navigator.of(context).push(CustomPageRoute2(page));
                },
                child: Container(
                  height: 76,
                  width: 76,
                  
                  decoration: BoxDecoration(
                    color: colorGrey,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Image.network(images[index]),
                ),
              );
            }, itemCount: images.length,
          ),
        )
      ],
    ),
  );
}