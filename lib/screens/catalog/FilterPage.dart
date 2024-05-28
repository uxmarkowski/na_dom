import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:na_dom/Widgets/appAndBottomBars/AppBarWidget.dart';
import 'package:na_dom/Widgets/generalCustomWidgets/CustomButton.dart';
import 'package:na_dom/Widgets/filterPage/FilterWidget.dart';
import 'package:na_dom/design.dart';

import '../../Widgets/generalCustomWidgets/CustomTextField.dart';
import 'AllTypesOfCormPage.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}
// ri_arrow-up-s-line.svg
class _FilterPageState extends State<FilterPage> {

  var minPriceFocusNode = FocusNode();
  var maxPriceFocusNode = FocusNode();

  var controllerMinPrice = TextEditingController();
  var controllerMaxPrice = TextEditingController();

  var classOfCormIndex = 0;
  var typeOfCormIndex = 0;
  var agePetIndex = 0;

  String? selectedValue;

  List listOfProducts = [];
  List listOfBrends = [];
  Map mapOfFilters = {
      "classOfCorm" : [],
      "typeOfCorm" : [],
      "ageOfPet" : []
    };

  void getFiltersToThisScreen () async {
    mapOfFilters["classOfCorm"].clear();
    mapOfFilters["typeOfCorm"].clear();
    mapOfFilters["ageOfPet"].clear();
    var _collection = await ref.child("categories").child("classOfCorm").get();
    var collectionChildren = _collection.children.toList();
    var _collection2 = await ref.child("categories").child("typeOfCorm").get();
    var collectionChildren2 = _collection2.children.toList();
    var _collection3 = await ref.child("categories").child("ageOfPet").get();
    var collectionChildren3 = _collection3.children.toList();

    var _collectionBrends = await ref.child("brends").get();
    var collectionBrendsChildren = _collectionBrends.children.toList();

    Map filterForAllBrends = {"title": "Все бренды"};
    listOfBrends.add(filterForAllBrends); // добавление в список брендов кнопку "Все бренды"
    selectedValue = filterForAllBrends["title"]; // сделать "Все бренды" выбранным по стандарту в списке

    Map filterForAllTypes = {"title": "Всё", "countOfProducts" : 0};
    mapOfFilters["classOfCorm"].add(filterForAllTypes); // добавление "все" в фильтры classOfCorm
    mapOfFilters["typeOfCorm"].add(filterForAllTypes);  // добавление "все" в фильтры typeOfCorm


    // добавление брендов из fire base в лист
    collectionBrendsChildren.forEach((doc) {
      var data = doc.value as Map;
      listOfBrends.add(data);
    });

    // добавление фильтров
    await Future.forEach(collectionChildren, (doc) {
      var data = doc.value as Map;
      data["countOfProducts"] = 0;
      setState(() {
        mapOfFilters["classOfCorm"].add(data);
      });
    });
    await Future.forEach(collectionChildren2, (doc) {
      var data = doc.value as Map;
      data["countOfProducts"] = 0;
      setState(() {
        mapOfFilters["typeOfCorm"].add(data);
      });
    });
    await Future.forEach(collectionChildren3, (doc) {
      var data = doc.value as Map;
      data["countOfProducts"] = 0;
      setState(() {
        mapOfFilters["ageOfPet"].add(data);
      });
    });

    setState(() {});
    print("mapOfFilters ${mapOfFilters}");

    // коррекция выбранных фильтров
    if(filters["minPrice"] != 0) {
      setState(() {
        controllerMinPrice.text = filters["minPrice"].toString();
      });
    }
    if(filters["maxPrice"] != 1000000) {
      setState(() {
        controllerMaxPrice.text = filters["maxPrice"].toString();
      });
    }
    if((filters["brend"] as List).isNotEmpty) { // сделать чтобы в настроках фильтров был выбранн нужный бренд который уже есть в фильтрах продуктов

      selectedValue = listOfBrends.where((element) => element["brendID"] == (filters["brend"] as List).first).first["title"];
    }
    if((filters["classOfCorm"] as List).isNotEmpty) { // если есть выбранный фильтр
      if ((filters["classOfCorm"] as List).length > 1) { // выбранно "всё"
        // print("значение не одно");
        setState(() {
          classOfCormIndex = 0;
        });
      } else {
        // print("значение одно");
        for(int i = 1; i < (mapOfFilters["classOfCorm"] as List).length; i++) { // если выбранно что-то одно ищем этов в общем массиве и присваиваем нужный интекс
          if ((filters["classOfCorm"] as List).first == mapOfFilters["classOfCorm"][i]["filterID"]) {
            // print("i получилось $i");
            setState(() {
              classOfCormIndex = i;
            });
          }
        }
      }
    }
    if((filters["typeOfCorm"] as List).isNotEmpty) { // если есть выбранный фильтр
      if ((filters["typeOfCorm"] as List).length > 1) { // выбранно "всё"
        setState(() {
          typeOfCormIndex = 0;
        });
      } else {
        for(int i = 1; i < (mapOfFilters["typeOfCorm"] as List).length; i++) { // если выбранно что-то одно ищем этов в общем массиве и присваиваем нужный интекс
          if ((filters["typeOfCorm"] as List).first == mapOfFilters["typeOfCorm"][i]["filterID"]) {
            // print("i получилось $i");
            setState(() {
              typeOfCormIndex = i;
            });
          }
        }
      }
    }
    if((filters["ageOfPet"] as List).isNotEmpty) { // если есть выбранный фильтр
      if ((filters["ageOfPet"] as List).length > 1) { // выбранно "любой"
        setState(() {
          agePetIndex = 0;
        });
      } else {
        for(int i = 1; i < (mapOfFilters["ageOfPet"] as List).length; i++) { // если выбранно что-то одно ищем этов в общем массиве и присваиваем нужный интекс
          if ((filters["ageOfPet"] as List).first == mapOfFilters["ageOfPet"][i]["filterID"]) {
            // print("i получилось $i");
            setState(() {
              agePetIndex = i;
            });
          }
        }
      }
    }


    // получить список всех продуктов
    var _collection4 = await ref.child("products").get();
    var collectionChildren4 = _collection4.children.toList();
    listOfProducts.clear();

    await Future.forEach(collectionChildren4, (doc) {
      var data = doc.value as Map;
      listOfProducts.add(data);
    });

    print("лист продуктов $listOfProducts");


    print("mapOfFilters before $mapOfFilters");

    // придать фильтрам нужное число

    mapOfFilters['typeOfCorm'][0]['countOfProducts'] = listOfProducts.length;
    mapOfFilters['ageOfPet'][0]['countOfProducts'] = listOfProducts.length;
    mapOfFilters['classOfCorm'][0]['countOfProducts'] = listOfProducts.length;

    listOfProducts.forEach((product) {
      product['petAge'].forEach((age) {
        if (mapOfFilters['ageOfPet'].any((filter) => filter['filterID'] == age)) {
          mapOfFilters['ageOfPet'].where((filter) => filter['filterID'] == age).forEach((filter) {
            filter['countOfProducts']++;

          });
        }
      });

      product['classOfCorm'].forEach((classOfCrom) {
      if (mapOfFilters['classOfCorm'].any((filter) => filter['filterID'] == classOfCrom)) {
        mapOfFilters['classOfCorm'].where((filter) => filter['filterID'] == classOfCrom).forEach((filter) {
          filter['countOfProducts']++;

        });
      }
      });

      product['typeOfCorm'].forEach((type) {
        if (mapOfFilters['typeOfCorm'].any((filter) => filter['filterID'] == type)) {
          mapOfFilters['typeOfCorm'].where((filter) => filter['filterID'] == type).forEach((filter) {
            filter['countOfProducts']++;
          });
        }
      });
    });
    print("mapOfFilters after $mapOfFilters");
    setState(() {

    });


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFiltersToThisScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          context: context,
          showSearchIcon: true,
          showContactsIcon: true,
          showPersonalPageIcon: true,
          showFaworiteIcon: false,
          showDeleteIcon: false
      ),
      body: GestureDetector(
        onTap: (){
          minPriceFocusNode.unfocus();
          maxPriceFocusNode.unfocus();
          if (controllerMinPrice.text.isNotEmpty) filters["minPrice"] = int.parse(controllerMinPrice.text);
          if (controllerMaxPrice.text.isNotEmpty) filters["maxPrice"] = int.parse(controllerMaxPrice.text);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: mapOfFilters["classOfCorm"].length == 0 ? Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(height: 36,),
                  // CupertinoActivityIndicator(),
                ],
              ),
            ) : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 36,),
                Text("Фильтр", style: textStyleB1,),
                SizedBox(height: 24,),
                Row(
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width - 48)/2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Цена от", style: textStyleB4Black2,),
                            SizedBox(height: 8,),
                            CustomTextField(
                                controller: controllerMinPrice,
                                focusNode: minPriceFocusNode,
                                hingText: "Цена от",
                                obscureText: false,
                                keyBoartIsNumbers: true,
                                onTextEditionComplete: (){
                                  filters["minPrice"] = int.parse(controllerMinPrice.text);
                                  print("filters from filter $filters");
                                },
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 12,),
                      Container(
                        width: (MediaQuery.of(context).size.width - 48)/2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Цена до", style: textStyleB4Black2,),
                            SizedBox(height: 8,),
                            CustomTextField(
                                controller: controllerMaxPrice,
                                focusNode: maxPriceFocusNode,
                                hingText: "Цена до",
                                obscureText: false,
                                keyBoartIsNumbers: true,
                                onTextEditionComplete: (){
                                  filters["maxPrice"] = int.parse(controllerMaxPrice.text);
                                  print("filters from filter $filters");
                                },

                            )
                          ],
                        ),
                      ),
                    ]
                ),
                SizedBox(height: 24,),
                Text("Бренды", style: textStyleB4Black2),
                SizedBox(height: 8,),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(

                    isExpanded: true,
                    hint: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Все бренды', // это не имеет значение потому что такая кнопка выбрана изначально а это для пустого списка
                            style: TextStyle(color: colorHintText, fontSize: 14, fontWeight: FontWeight.normal),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: listOfBrends.map((item) => DropdownMenuItem<String>(
                      value: item["title"],
                      child: Text(
                        item["title"],
                        style: TextStyle(color: colorHintText, fontSize: 14, fontWeight: FontWeight.normal),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )).toList(),

                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                      filters["brend"].clear();
                      if (value == "Все бренды") {
                        // оставим массив с фильтрами пустым тогда пройдут все фильтры
                      } else {
                        (filters["brend"] as List).add(listOfBrends.where((element) => element["title"] == value).first["brendID"]);
                      }
                      print("filters $filters");
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 44,
                      width: MediaQuery.of(context).size.width - 32,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: colorBorderTextField,
                        ),
                        color: Colors.white,
                      ),
                      elevation: 0,
                    ),
                    iconStyleData: const IconStyleData(
                      icon: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                      iconSize: 14,
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: Colors.grey,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 200,
                      width: MediaQuery.of(context).size.width - 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      offset: const Offset(0, 0),
                      scrollbarTheme: ScrollbarThemeData(
                        radius: const Radius.circular(40),
                        thickness: MaterialStateProperty.all(4),
                        thumbVisibility: MaterialStateProperty.all(true),
                      ),
                    ),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 44,
                      padding: EdgeInsets.only(left: 12, right: 12),
                    ),
                  ),
                ),
                SizedBox(height: 24,),
                Text("Класс корма", style: textStyleB4Black2),
                SizedBox(height: 8,),
                Wrap(
                  spacing: 12.0,
                  runSpacing: 12.0,
                  children: List.generate(mapOfFilters["classOfCorm"].length, (index)  {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FilterWidget(
                            context: context,
                            index: classOfCormIndex,
                            InsideActiveIndex: index,
                            widgetIsLong: (index != (mapOfFilters["classOfCorm"].length - 1) || (mapOfFilters["classOfCorm"].length % 2) == 0 ) ? false : true,
                            // если элемент не последний или общее число элементов чётное возвращаем false (элемент короткий)
                            text: mapOfFilters["classOfCorm"][index]["title"],
                            count: mapOfFilters["classOfCorm"][index]["countOfProducts"],
                            function: () {
                              setState(() {
                                classOfCormIndex = index;
                              });
                              filters["classOfCorm"].clear();
                              if (index == 0) {
                                for (int i = 1; i < (mapOfFilters["classOfCorm"] as List).length; i++ ) {
                                  (filters["classOfCorm"] as List).add(mapOfFilters["classOfCorm"][i]["filterID"]);
                                }
                              } else {
                                (filters["classOfCorm"] as List).add(mapOfFilters["classOfCorm"][index]["filterID"]);
                              }
                            }

                        ),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 24,),
                Text("Тип корма", style: textStyleB4Black2),
                SizedBox(height: 8,),
                Wrap(
                  spacing: 12.0,
                  runSpacing: 12.0,
                  children: List.generate(mapOfFilters["typeOfCorm"].length, (index)  {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FilterWidget(
                            context: context,
                            index: typeOfCormIndex,
                            InsideActiveIndex: index,
                            widgetIsLong: (index != (mapOfFilters["typeOfCorm"].length - 1) || (mapOfFilters["typeOfCorm"].length % 2) == 0 ) ? false : true,
                            // если элемент не последний или общее число элементов чётное возвращаем false (элемент короткий)
                            text: mapOfFilters["typeOfCorm"][index]["title"],
                            count: mapOfFilters["typeOfCorm"][index]["countOfProducts"],
                            function: () {
                              setState(() {
                                typeOfCormIndex = index;
                              });
                              filters["typeOfCorm"].clear();
                              if (index == 0) {
                                for (int i = 1; i < (mapOfFilters["typeOfCorm"] as List).length; i++ ) {
                                  (filters["typeOfCorm"] as List).add(mapOfFilters["typeOfCorm"][i]["filterID"]);
                                }
                              } else {
                                (filters["typeOfCorm"] as List).add(mapOfFilters["typeOfCorm"][index]["filterID"]);
                              }
                            }
                        ),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 24,),
                Text("Возраст питомца", style: textStyleB4Black2),
                SizedBox(height: 8,),
                Wrap(
                  spacing: 12.0,
                  runSpacing: 12.0,
                  children: List.generate(mapOfFilters["ageOfPet"].length, (index)  {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FilterWidget(
                            context: context,
                            index: agePetIndex,
                            InsideActiveIndex: index,
                            widgetIsLong: (index != (mapOfFilters["ageOfPet"].length - 1) || (mapOfFilters["ageOfPet"].length % 2) == 0 ) ? false : true,
                            // если элемент не последний или общее число элементов чётное возвращаем false (элемент короткий)
                            text: mapOfFilters["ageOfPet"][index]["title"],
                            count: mapOfFilters["ageOfPet"][index]["countOfProducts"],
                            function: () {
                              setState(() {
                                agePetIndex = index;
                              });
                              filters["ageOfPet"].clear();
                              if (index == 0) {
                                for (int i = 1; i < (mapOfFilters["ageOfPet"] as List).length; i++ ) {
                                  (filters["ageOfPet"] as List).add(mapOfFilters["ageOfPet"][i]["filterID"]);
                                }
                              } else {
                                (filters["ageOfPet"] as List).add(mapOfFilters["ageOfPet"][index]["filterID"]);
                              }
                            }
                        ),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 36,),
                MyButton(onTap: (){
                  Navigator.pop(context);
                }, text: "Сохранить"),
                SizedBox(height: 24,)
              ],
            ),
          )
        ),
      ),
    );
  }
}
