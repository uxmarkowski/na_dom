import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:na_dom/Widgets/appAndBottomBars/AppBarWidget.dart';
import 'package:na_dom/design.dart';
import 'package:na_dom/screens/mainScreens/BrendPage.dart';

import '../../Widgets/custom_route.dart';
import '../catalog/AllTypesOfCormPage.dart';

class AllBrendsPage extends StatefulWidget {
  const AllBrendsPage({Key? key}) : super(key: key);

  @override
  State<AllBrendsPage> createState() => _AllBrendsPageState();
}

class _AllBrendsPageState extends State<AllBrendsPage> {

  var searchFoucesNode = FocusNode();
  var searchController = TextEditingController();

  List listOfBrends = [];
  List listOfBrendsCopy = [];

  getBrendsFromFireBase () async {
    listOfBrends.clear();
    var _collection = await ref.child("brends").get();
    var collectionChildren = _collection.children.toList();

    await Future.forEach(collectionChildren, (doc) {
      var data = doc.value as Map;
      setState(() {
        listOfBrends.add(data);
      });
    });

    listOfBrendsCopy = listOfBrends;

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBrendsFromFireBase();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          context: context,
          showSearchIcon: false,
          showContactsIcon: true,
          showPersonalPageIcon: true,
          showFaworiteIcon: false,
          showDeleteIcon: false
      ),
      body: GestureDetector(
        onTap: (){
          searchFoucesNode.unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 36,),
                Text("Все бренды", style: textStyleB1,),
                SizedBox(height: 12,),
                CupertinoSearchTextField(
                  controller: searchController,
                  focusNode: searchFoucesNode,
                  placeholder: "Поиск",
                  onChanged: (value) => setState ((){
                    listOfBrends = List.from(listOfBrendsCopy.map((categotyMap) => Map.from(categotyMap)));
                    if(value.isNotEmpty) listOfBrends.removeWhere((element) => element["title"].toString().toLowerCase().contains(value.toLowerCase()) == false);
                  })
                ),
                SizedBox(height: 12,),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: InkWell(
                          onTap: () {
                            final page = BrendPage(brendID: listOfBrends[index]["brendID"],);
                            Navigator.of(context).push(CustomPageRoute2(page));
                          },
                        child: Text(listOfBrends[index]["title"], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: colorDevider,
                        thickness: 1,
                      );
                    },
                  itemCount: listOfBrends.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
