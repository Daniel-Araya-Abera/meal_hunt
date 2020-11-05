import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mealhunt/models/meal.dart';

class MealDetailPage extends StatefulWidget {
  String url;

  MealDetailPage({@required this.url});

  @override
  _MealDetailPageState createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  List<Meal> mealsList = new List<Meal>();

  Map<String, dynamic> parsedJson;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getMeal(widget.url);
  }

  String res;

  void getMeal(String url) async {
    var response = await http.get(url);
    parsedJson = jsonDecode(response.body);
    print("aprsed json is  now is ");
//    print(parsedJson);
    List mealsFromJson = parsedJson["meals"];

    mealsList = mealsFromJson.map((i) => Meal.fromJson(i)).toList();

    setState(() {
      isLoaded = true;
    });

    print(mealsFromJson.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Page"),
        elevation: 0.0,
      ),
      body: isLoaded == true
          ? Container(
              color: Colors.orange[100],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 80.0, 40.0, 0.0),
                child: Container(
                  child: ListView.builder(
                    itemCount: mealsList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 15.0,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(300),
                            child: Container(
                              width: 300,
                              height: 300,
                              child:
                                  Image.network(mealsList[index].strMealThumb),
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Text(
                            mealsList[index].strCategory,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 32),
                          ),
                          Text(
                            mealsList[index].strMeal,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          SizedBox(
                            height: 120.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ButtonTheme(
                                minWidth: 160.0,
                                height: 50.0,
                                child: RaisedButton(
                                  elevation: 2,
                                  splashColor: Colors.blue,
                                  color: Colors.lightBlue,
                                  onPressed: () {},
                                  child: Text("Ingredients"),
                                ),
                              ),
                              ButtonTheme(
                                minWidth: 160.0,
                                height: 50.0,
                                child: RaisedButton(
                                  elevation: 2,
                                  splashColor: Colors.blue,
                                  color: Colors.lightBlue,
                                  onPressed: () {},
                                  child: Text("Instructions"),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            )
          : Container(
              child: Text("loading"),
            ),
    );
  }
}
