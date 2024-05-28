import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


var model = hive_example();


class hive_example {
  hive_example() {
    Hive.initFlutter();
  }


  saveCart(cart) async{
    var box = await Hive.openBox("cart");
    await box.put("cart", cart);
  }


  getCart() async{

    var box = await Hive.openBox("cart");
    if(box.isEmpty) { return []; }
    var boxData = await box.get("cart");

    return boxData;
  }

  clearCart() async{

    var box = await Hive.openBox("cart");
    box.clear();
  }



}

