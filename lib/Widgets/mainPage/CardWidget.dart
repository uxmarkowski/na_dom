import 'package:flutter/material.dart';

Widget CardWidget ({
  required context,
  required List pets,
  required functionTransition,
}) {
  return InkWell(
    onTap: (){
      functionTransition();
    },
    child: Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("lib/assets/backgroundCard.png"),
            fit: BoxFit.cover
        ),
        borderRadius: BorderRadius.circular(12),
        //color: Colors.black
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Карточка постоянного покупателя", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),),
            SizedBox(height: 4,),
            if (pets.isNotEmpty) Container(
              width: 320,
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Text("${pets[index]}${index == (pets.length - 1) ? "" : ","}", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 8,);
                },
                itemCount: pets.length,
              ),
            ),
            if (pets.isEmpty) Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1,color: Colors.white)),
                  ),
                  child: Text("Добавить питомца", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),),
                )
              ]
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("5%", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),),
                SizedBox(width: 12,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Постоянная скидка", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),),
                    Text("на все товары", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}