import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:na_dom/Widgets/appAndBottomBars/AppBarWidget.dart';
import 'package:na_dom/Widgets/appAndBottomBars/BottomNavigationBarWidget.dart';
import 'package:na_dom/Widgets/catalogPage/LongCatalogButtonWidget.dart';
import 'package:na_dom/Widgets/catalogPage/LongCatalogCategoryButton.dart';
import 'package:na_dom/Widgets/catalogPage/ShortCatalogCategoryButton.dart';
import 'package:na_dom/design.dart';
import 'package:na_dom/Widgets/hive_metod.dart';

import '../../Functions.dart';
import '../../Widgets/custom_route.dart';
import '../../Widgets/productWidgets/ProductScrollImageWidget.dart';
import '../../Widgets/productWidgets/ChooseCormMassWidget.dart';
import '../../Widgets/productWidgets/ProductWidget.dart';
import 'ProductPage.dart';


void incrementPopularity ({required productID}) async {
  var _collection = await ref.child("products").get();
  var collectionChildren = _collection.children.toList();

  Future.forEach(collectionChildren, (doc) async{
    var data = doc.value as Map;
    if (data["docID"] == productID) { // находим наш продукт то есть продукт с таким же docID
      print("я нашёл продукт");
      data["popularity"]++;
      await ref.child("products").child(data["docID"]).update({
        "popularity" : data["popularity"],
      });
    }
  });
}


List listOfFilters = [
  // classOfCorm
  { "name" : "Эконом", "filterID" : "" },
  { "name" : "Премиум", "filterID" : "" },
  { "name" : "Супер-премиум", "filterID" : "" },
  { "name" : "Холистик", "filterID" : "" },

  // typeOfCorm
  { "name" : "Сухие", "filterID" : "" },
  { "name" : "Консервы", "filterID" : "" },
  { "name" : "Влажные", "filterID" : "" },
  { "name" : "Лечебные", "filterID" : "" },
  { "name" : "Лакомства", "filterID" : "" },
  { "name" : "Для стерилизованых", "filterID" : "" },

  // petAge
  { "name" : "Щенок/котенок", "filterID" : "" },
  { "name" : "Взрослый", "filterID" : "" },
  { "name" : "Пожилой", "filterID" : "" },

];
Map filters = {
  "minPrice" : 0,
  "maxPrice" : 1000000,
  "catalog" : [],
  "brend" : [],
  "classOfCorm" : [],
  "typeOfCorm" : [],
  "ageOfPet" : [],
};


DatabaseReference ref = FirebaseDatabase.instance.ref();
FirebaseAuth auth = FirebaseAuth.instance;



class AllTypesOfCormPage extends StatefulWidget {
  final category;
  const AllTypesOfCormPage({Key? key, this.category}) : super(key: key);

  @override
  State<AllTypesOfCormPage> createState() => _AllTypesOfCormPageState();
}

class _AllTypesOfCormPageState extends State<AllTypesOfCormPage> {

  var finalResult = "По актуальности ↑";
  var indexOfFilterSort = 0;
  var titleOfpage = "";

  var searchFoucesNode = FocusNode();
  var searchController = TextEditingController();

  List<Map> listOfProducts = [];
  List<Map> listOfProductsCopy = [];

  var cart = [];
  var listOfCategories = [];
  var lastElement;
  var listOstatoc;

  // фильтры
  bool checkIfListsContainSameID(list1, List list2) {

    if(list1.runtimeType == String) {

      for (String secondID in list2) { // если list1 это бренд и там не может быть нескольких значение
        if (list1 == secondID) {
          return true;
        }
      }
    } else { // если даётся два листа и нужно найти у обоих общее значение
      for (String firstID in list1) {
        for (String secondID in list2) {
          if (firstID == secondID) {
            return true;
          }
        }
      }
    }
    return false;
  }
  void filterProductsForPrice(List products, int minPrice, int maxPrice) {
    products.removeWhere((product) {
      bool isPriceInRange = true;
      for (int i = 0; i < product["price"].length; i++) {
        int discountedPrice = (product["price"][i] * (100 - product["discount"]) / 100).round();
        if (discountedPrice >= minPrice && discountedPrice <= maxPrice) {
          setState(() {
            product["сhoosenCormMassIndex"] = i;
          });
          isPriceInRange = false;
          break;
        }
      }
      return isPriceInRange;
    });
  }


  // сортировка
  void sortListOfProductsMaxToMinPrice () {
    setState(() {
      listOfProducts.sort((a, b) => b['price'][b['сhoosenCormMassIndex']].compareTo(a['price'][a['сhoosenCormMassIndex']]));
    });
  }
  void sortListOfProductsMinToMaxPrice () {
    setState(() {
      listOfProducts.sort((a, b) => a['price'][a['сhoosenCormMassIndex']].compareTo(b['price'][b['сhoosenCormMassIndex']]));
    });
  }
  void sortListOfProductsMaxToMinPopularity () {
    setState(() {
      listOfProducts.sort((a, b) => b['popularity'].compareTo(a['popularity']));
    });
  }


  // товар
  void functionChangeCormMassIndex (int index, int indexOfObject) {
    setState(() { listOfProducts[indexOfObject]["сhoosenCormMassIndex"] = index; });

    if (cart.where((element) => element["docID"] == listOfProducts[indexOfObject]["docID"]).isNotEmpty) {

      cart.removeWhere((element) => element["docID"] == listOfProducts[indexOfObject]["docID"]);
      cart.add(listOfProducts[indexOfObject]);
      model.saveCart(cart);

    }
    // print("cart affter $cart");

  } // поменять выбранную массу продукта
  void changeImageIndex (int imageIndex, int indexOfProduct) {
    setState(() {
      listOfProducts[indexOfProduct]["imageIndex"] = imageIndex;
    });
  } // поменять выбранную картинку в продукте
  void changeCountOfProduct (int, indexOfObject) {
    if (int == 1) {
      setState(() { listOfProducts[indexOfObject]["countOfTowar"]++; });
      // увеличить число продуктов
      if (cart.where((element) => element["docID"] == listOfProducts[indexOfObject]["docID"]).isNotEmpty) {

        cart.removeWhere((element) => element["docID"] == listOfProducts[indexOfObject]["docID"]);
        cart.add(listOfProducts[indexOfObject]);
        model.saveCart(cart);

      } else {
        cart.add(listOfProducts[indexOfObject]);
      }

    } else {
      if (listOfProducts[indexOfObject]["countOfTowar"] > 1) {
        setState(() { listOfProducts[indexOfObject]["countOfTowar"]--; });
        // уменьшить число продуктов
        if (cart.where((element) => element["docID"] == listOfProducts[indexOfObject]["docID"]).isNotEmpty) {

          cart.removeWhere((element) => element["docID"] == listOfProducts[indexOfObject]["docID"]);
          cart.add(listOfProducts[indexOfObject]);
          model.saveCart(cart);

        }
      } else {
        setState(() { listOfProducts[indexOfObject]["countOfTowar"] = 0; });
        // удаляем из корзины

        cart.removeWhere((element) => element["docID"] == listOfProducts[indexOfObject]["docID"]);
      }
    }
    model.saveCart(cart);
    // print("cart affter $cart");
  } // изменить число продуктов


  // fire base
  void NewEstateBlockWidget () async{
    var newCollection = await ref.child("products").get();
    var newId = DateTime.now().millisecondsSinceEpoch.toString();
    await ref.child("UsersCollection").child("+79788759240").set(
    {
    "phone":"+79788759240",
    "name":"Serege",
    });
  } // добавить пользователя в fire base
  void NewProduct () async{
    var newCollection = await ref.child("products").get();
    var newId = DateTime.now().millisecondsSinceEpoch.toString();
    await ref.child("products").child(newId).set({
      "title" : "Корм сухой BOWL WOW супер премиум с индейкой, рисом и шпинатом для щенков мелких пород полнорационный, натуральный с высоким содержанием белка для суставов и иммунитета",
      "discount" : 10,
      "price" : [800, 1824, 3720],
      "massTypes" : ["800гр", "2кг", "5кг"],
      "listOfImages" : [
        "https://ir.ozone.ru/s3/multimedia-q/wc1000/6733160666.jpg",
        "https://ir.ozone.ru/s3/multimedia-7/wc1000/6733160683.jpg",
        "https://ir.ozone.ru/s3/multimedia-x/wc1000/6733127013.jpg",
      ],

      "brendID" : "1715635126659",
      "docID" : newId,

      "classOfCorm" : "Класс корма",
      "petAge" : "Взрослый",
      "petSize" : "Для крупных пород",
      "petActivity" : "Любая",
      "specialNeeds" : [
        "Здоровое животное", "Чувствительное пищеваревание", "Аллрегик проблемы с кожей", "Для здоровья кожи и шерсти", "Для костей и суставов", "Профилактика МКБ",
      ],
      "ingredients" : ["Индейка", "Бурый рич"],
      "allIngredients" : "дегидрированное мясо ягненка (12%), дегидрированное мясо индейки (12%), дегидрированное мясо утки (12%), дегидрированное мясо дикого кабана (12%), цельнозерновой коричневый рис, свежее мясо индейки (10%), жир индейки (5%), сушеный батат, свежее масло лосося (1%), порошок корней цикория (натуральный источник пребиотиков: ФОС и инулин), сушеный антарктический криль (натуральный источник ЭПК и ДГК кислот, 1%), сушеное яблоко, мука из плодов рожкового дерева, пивные дрожжи (натуральный источник МОС), глюкозамин (1500 мг/кг), Хондроитин сульфат (1000 мг/кг), MSM (метилсульфонилметан, 40 мг/кг), сушеная клюква, Юкка Мохаве. Кроме заявленных в составе животных ингредиентов продукт может содержать следы ДНК других",

    });
  } // добавить продукт в fire base
  void NewNews () async {
    var newCollection = await ref.child("news").get();
    var newId = DateTime.now().millisecondsSinceEpoch.toString();
    await ref.child("news").child(newId).set({
    "image" : "https://images.unsplash.com/photo-1506755855567-92ff770e8d00?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "title" : "Лакомства",
    "desctiption" : "Лакомство - это приятный сюрприз для вашей кошки, но в этом отношении необходимо соблюдать умеренность, иначе кошка очень быстро наберет лишний вес. В качестве лакомств лучше использовать специально предназначенные для этого продукты, выпускаемые с этой целью производителями кормов и пищевых добавок для животных, а не остатки еды со стола и не сырое мясо.",

    "newsID" : newId,
    });
  } // добавить новость в fire base
  void NewBrend () async {
    var newCollection = await ref.child("brends").get();
    var brendID = DateTime.now().millisecondsSinceEpoch.toString();
    await ref.child("brends").child(brendID).set({
      "brendID" : brendID,
      "title" : "Chappi",
      "desctiption" : "Chappi - это бренд, созданный на основе философии 'максимально естественное питание'. Корма Chappi содержат высококачественные ингредиенты, вдохновленные дикой природой, чтобы удовлетворить инстинкты вашего питомца.",
    });
  } // добавить бренд в fire base
  void NewCategory () async {
    var newCollection = await ref.child("categories").get();
    var docID = DateTime.now().millisecondsSinceEpoch.toString();
    await ref.child("categories").child("ageOfPet").child(docID).set({
      "filterID" : docID,
      "title" : "Пожилой",
      // "desctiption" : "ветеринарные",
    });

  } // добавить категорию или фильтр в fire base

  void updateProduct () async {
    var _collection = await ref.child("products").get();
    var collectionChildren = _collection.children.toList();

    await Future.forEach(collectionChildren, (doc) async {
      var data = doc.value as Map;
      if (data["docID"] == "1715622461910") {
        print("я нашёл продукт");
        await ref.child("products").child(data["docID"]).update({
          "popularity" : 0,
        });
      }
    });
    setState(() {});

  } // добавить или изменить что-то в конкретном продукте

  void getProductsAndSort () async {
    var _collection = await ref.child("products").get();
    var collectionChildren = _collection.children.toList();
    var _collection2 = await ref.child("categories").child("catalog").get();
    var collectionChildren2 = _collection2.children.toList();
    listOfProducts.clear();

    await Future.forEach(collectionChildren, (doc) {
      var data = doc.value as Map;

      // причисляем новые значение уже в самом приложении
      // так как этим значениям не нужно хранитья в firebase у продуктов
      data["сhoosenCormMassIndex"] = 0;
      data["countOfTowar"] = 0;
      data["imageIndex"] = 0;

      listOfProducts.add(data);
    });

    listOfCategories.clear();
    (filters["catalog"] as List).clear();

    // добавление категории в массив и фльтр
    if ((widget.category as List).isEmpty) {

      // добавляем все категории в список сверху а фильтр оставляем пустым
      await Future.forEach(collectionChildren2, (doc) {
        var data = doc.value as Map;
        listOfCategories.add(data);
        print("data listOfCategories: $listOfCategories");
      });

      setState(() {
        titleOfpage = "Все категории";
      });

    } else {
      // добавляем нашу категорию в фильтр и в список сверху

      await Future.forEach(collectionChildren2, (doc) {
        var data = doc.value as Map;
        if (data["catalogID"] == (widget.category as List).first) {
          listOfCategories.add(data);
          // меняем загловок
          setState(() {
            titleOfpage = data["title"];
          });
          // добалвяем в фильтр
          (filters["catalog"] as List).add(data["catalogID"]);
        }
      });

    }

    setState(() {});

    cart = await model.getCart();

    // корректируем то что мы получили в fire base с тем что у нас хранится в корзине (hive)
    for (int i = 0; i < listOfProducts.length; i++) {
      if (cart.where((cartProduct) => cartProduct["docID"] == listOfProducts[i]["docID"]).isNotEmpty) {
        var countOfProductInCart = cart.where((element) => element["docID"] == listOfProducts[i]["docID"]).first["countOfTowar"];
        var indexOfCormMassInCart = cart.where((element) => element["docID"] == listOfProducts[i]["docID"]).first["сhoosenCormMassIndex"];

        setState(() {
          listOfProducts[i]["countOfTowar"] = countOfProductInCart;
          listOfProducts[i]["сhoosenCormMassIndex"] = indexOfCormMassInCart;
          // listOfProducts[i]["price"] = listOfProducts[i]["price"] * countOfProductInCart;
        });
      }
    }


    // фильтруем

    print("filters before $filters");
    print("listOfProducts $listOfProducts");
    if ( filters["minPrice"] < filters["maxPrice"]) {
      filterProductsForPrice(listOfProducts, filters["minPrice"], filters["maxPrice"]); // по цене
    }

    if((filters["catalog"] as List).isNotEmpty) {
      print("фильтр catalog");
      listOfProducts.removeWhere((element) => checkIfListsContainSameID(element["catalogID"], filters["catalog"]) == false);
    } // фильтр категории

    if((filters["brend"] as List).isNotEmpty) {
      print("фильтр brend");
      print(listOfProducts);
      listOfProducts.removeWhere((element) => checkIfListsContainSameID(element["brendID"], filters["brend"]) == false);
    } // фильтр бренда

    if((filters["classOfCorm"] as List).isNotEmpty) {
      print("фильтр classOfCorm");
      listOfProducts.removeWhere((element) => checkIfListsContainSameID(element["classOfCorm"], filters["classOfCorm"]) == false);
    } // фильтр класс корма

    if((filters["typeOfCorm"] as List).isNotEmpty) {
      print("фильтр classOfCorm");
      listOfProducts.removeWhere((element) => checkIfListsContainSameID(element["typeOfCorm"], filters["typeOfCorm"]) == false);
    } // фильтр тип корма

    if((filters["ageOfPet"] as List).isNotEmpty) {
      print("фильтр ageOfPet");
      listOfProducts.removeWhere((element) => checkIfListsContainSameID(element["petAge"], filters["ageOfPet"]) == false);
    } // фильтры возраст питомца


    // сортировка по стандарту
    if (indexOfFilterSort == 0) {
      sortListOfProductsMaxToMinPopularity();
    }

    // создание массива копии
    listOfProductsCopy = listOfProducts;

  } // получить все продукты из fire base


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductsAndSort();
    if (listOfCategories.isNotEmpty) {
      lastElement = listOfCategories.last["title"];
      listOstatoc = listOfCategories.length % 2; // если равен нулю то количество категорий чётное елси одному то нечётное
    }
    // print(auth.currentUser?.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
          context: context,
          showSearchIcon: false,
          showContactsIcon: true,
          showPersonalPageIcon: true,
          showFaworiteIcon: false,
          showDeleteIcon: false
      ),
      bottomNavigationBar: BottomNavigationBarWidget(currentBottomBarIndex: 1, context: context),
      body: GestureDetector(
        onTap: (){
          searchFoucesNode.unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: listOfCategories.isNotEmpty ?
            Column(
              children: [
                if (listOfCategories.length > 1) SizedBox(height: 24,),
                if (listOfCategories.length > 1) Wrap(
                  spacing: 16.0,
                  runSpacing: 12.0,
                  children: listOfCategories.map((item) {
                    if (item["title"] != lastElement || listOstatoc == 0) { // если элемент не последний или общее число элементов нечётное
                      return ShortCatalogCategoryButton(
                          context: context,
                          function: (){
                            final page = AllTypesOfCormPage(category: [item["catalogID"]],);
                            Navigator.of(context).push(CustomPageRoute2(page));
                          },
                          text: item["title"],
                          description: item["description"]
                      );
                    } else { // если элемент последний и число элементов массива нечётное
                      return LongCatalogCategoryButton(
                          context: context,
                          function: (){
                            final page = AllTypesOfCormPage(category: [item["catalogID"]],);
                            Navigator.of(context).push(CustomPageRoute2(page));
                          },
                          text: item["title"],
                          description: item["description"]
                      );
                    }
                  }).toList(),
                ),
                SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(titleOfpage, style: textStyleB1,),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/filterPage').then((value) => getProductsAndSort());
                      },
                      child: SvgPicture.asset("lib/assets/Filter.svg"),
                    ),
                  ],
                ),
                SizedBox(height: 12,),
                CupertinoSearchTextField(
                  controller: searchController,
                  focusNode: searchFoucesNode,
                  placeholder: "Поиск",
                  onChanged: (value) => setState ((){
                    listOfProducts = List.from(listOfProductsCopy.map((categotyMap) => Map.from(categotyMap)));
                    if(value.isNotEmpty) listOfProducts.removeWhere((element) => element["title"].toString().toLowerCase().contains(value.toLowerCase()) == false);
                  })
                ),
                SizedBox(height: 16,),
                Row(
                  children: [
                    SvgPicture.asset("lib/assets/Sortdown.svg"),
                    SizedBox(width: 8,),
                    GestureDetector(
                      onTap: () {

                        // NewEstateBlockWidget();
                        // NewProduct();
                        // NewNews();
                        // NewBrend();
                        // NewCategory();
                        updateProduct();

                        if(indexOfFilterSort == 2) {
                          indexOfFilterSort = 0;
                        } else {
                          indexOfFilterSort++;
                        }
                        if (indexOfFilterSort == 0) {
                          setState(() {
                            finalResult = "По актуальности";
                          });
                          sortListOfProductsMaxToMinPopularity();




                        } else if (indexOfFilterSort == 1) {
                          setState(() {
                            finalResult = "По цене ↑";
                          });
                          sortListOfProductsMinToMaxPrice();


                        } else {
                          setState(() {
                            finalResult = "По цене ↓";
                          });
                          sortListOfProductsMaxToMinPrice();


                        }
                      },
                      child: Row(
                        children: [
                          Text("Сортировка: $finalResult", style: textStyleB3,),
                        ],
                      )
                    )
                  ],
                ),
                SizedBox(height: 36,),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return ProductWidget(
                          title: listOfProducts[index]["title"],
                          discount: listOfProducts[index]["discount"] ?? 0,
                          price: listOfProducts[index]["price"],
                          masTypes: listOfProducts[index]["massTypes"],
                          listOfImages: listOfProducts[index]["listOfImages"],
                          chooseCormMassIndex: listOfProducts[index]["сhoosenCormMassIndex"],
                          countOfTowar: listOfProducts[index]["countOfTowar"],
                          docID: listOfProducts[index]["docID"],


                          context: context,
                          idexOfObject: index,
                          indexOfImage: listOfProducts[index]["imageIndex"],
                          functionChangeImageIndex: changeImageIndex,
                          functionChangeCormMassIndex: functionChangeCormMassIndex,
                          changeCountOfProduct: changeCountOfProduct, 
                          transitionFunction: (){
                          final page = ProductPage(docID: listOfProducts[index]["docID"]);
                          Navigator.of(context).push(CustomPageRoute2(page)).then((value) => getProductsAndSort());
                          incrementPopularity(productID: listOfProducts[index]["docID"]);
                        },
                      );
                    },
                    separatorBuilder: (context, index){
                      return SizedBox(height: 36,);
                    },
                    itemCount: listOfProducts.length
                ),
                SizedBox(height: 36,),
              ],
            ) : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Загрузка ", style: textStyleL3,),
                    SizedBox(width: 4,),
                    CupertinoActivityIndicator(),
                  ],
                )
              ],
            )
          )
        ),
      ),
    );
  }
}





