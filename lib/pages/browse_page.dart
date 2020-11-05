import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mealhunt/models/category.dart';
import 'package:mealhunt/constants/api_endpoints.dart';
import 'package:mealhunt/models/meal.dart';
import 'package:mealhunt/pages/meal_detail_page.dart';

class BrowsePage extends StatefulWidget {
  @override
  _BrowsePageState createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  List<Category> categoriesList = new List<Category>();

  Map<String, dynamic> parsedJson;
  bool isLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategories(mealCategories);
  }

  bool subListLoaded = false;
  Map<String, List<Meal>> mealsOfEachCategories = new Map<String, List<Meal>>();

  void getCategories(String url) async {
    var response = await http.get(url);
    parsedJson = jsonDecode(response.body);
    print("aprsed json is  now is ");
    print(parsedJson);
    List categoriesFromJson = parsedJson["categories"];

    print("categories from json is");
    print(categoriesFromJson);
    categoriesList =
        categoriesFromJson.map((i) => Category.fromJson(i)).toList();
    print("categories list is ");

    setState(() {
      isLoaded = true;
    });

    print(categoriesFromJson.toString());

    for (var i = 0; i < categoriesList.length; i++) {
      await _buildSublistOfSpecifiedCategory(categoriesList[i].strCategory);
    }

    mealsOfEachCategories.forEach((key, value) {
      print("key --> " + key + " and value ");
      List<Meal> curr = value;
      curr.forEach((element) {
        print("\t\t here " + element.strMeal);
      });
      print("finished ***********************************");
    });

    setState(() {
      subListLoaded = true;
    });
  }

  void _buildSublistOfSpecifiedCategory(String strCategory) async {
    String url = filterMealsByCategory + strCategory;
    var response = await http.get(url);
    var parsedJson = jsonDecode(response.body);
    print("sublist parsed json is  now is ");
    print(parsedJson);

    List mealsFromJson = parsedJson["meals"];

    List<Meal> currMealsList =
        mealsFromJson.map((i) => Meal.fromJson(i)).toList();
    mealsOfEachCategories[strCategory] = currMealsList;

//    print("meals of each categories is now ");
//    print(mealsOfEachCategories);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Browse Page"),
        elevation: 0.0,
      ),
      body: isLoaded == true
          ? Container(
//              color: Colors.orange[100],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
                child: Container(
                  child: ListView.builder(
                    itemCount: categoriesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
//                          ClipRRect(
//                            borderRadius: BorderRadius.circular(300),
//                            child: Container(
//                              width: 200,
//                              height: 200,
//                              child: Image.network(
//                                  categoriesList[index].strCategoryThumb),
//                            ),
//                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  await showDialog(
                                    context: context,
//                                  child: ImageDialog(imageUrl: categoriesList[index].strCategoryThumb),
                                    builder: (_) => ImageDialog(
                                      imageUrl: categoriesList[index]
                                          .strCategoryThumb,
                                    ),
                                  );
                                },
                                child: Text(
                                  categoriesList[index].strCategory,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32),
                                ),
                              ),
                            ],
                          ),
//                          Center(
//                            child: Text(
//                              categoriesList[index].strCategoryDescription,
//                              style: TextStyle(
//                                fontWeight: FontWeight.w300,
//                                fontSize: 18,
//                                wordSpacing: 2.0,
//                              ),
//                            ),
//                          ),

//                        Container(
//                          child: Text("len of innner list " + mealsOfEachCategories[categoriesList[index].strCategory].length.toString()),
//                        ),
                          subListLoaded == true
                              ? Container(
                                  height: 220,
//                                  color: Colors.blue,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: mealsOfEachCategories[
                                            categoriesList[index].strCategory]
                                        .length,
                                    itemBuilder:
                                        (BuildContext context, int subIndex) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            String mealUrl = mealDetail + mealsOfEachCategories[categoriesList[index].strCategory][subIndex].idMeal;

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => MealDetailPage(
                                                    url: mealUrl,
                                                  ),
                                                ));
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 200,
//                                              height: 120,
                                                height: 220,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.elliptical(400, 90)),
                                                  child: Image.network(
                                                      mealsOfEachCategories[
                                                                  categoriesList[
                                                                          index]
                                                                      .strCategory]
                                                              [subIndex]
                                                          .strMealThumb),
                                                ),
                                              ),
                                              Positioned(
//                                              left: 20.0,
                                                right: 20.0,
                                                bottom: 20.0,
                                                child: Stack(
                                                  children: [
                                                    Text(
                                                        mealsOfEachCategories[categoriesList[index].strCategory][subIndex].strMeal,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white,
                                                      ),

                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Container(
                                  height: 240,
                                  color: Colors.blue,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 4,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        color: Colors.orange,
                                        height: 120,
                                        width: 200,
                                        child: Text("loading.."),
                                      );
                                    },
                                  ),
                                ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            )
          : Container(child: Text("loading..")),
    );
  }
}

class ImageDialog extends StatelessWidget {
  final String imageUrl;

  ImageDialog({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
//        color: Colors.orange,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(
            imageUrl,
            width: 30,
            height: 30,
          ),
        ),
      ),
    );
  }
}
