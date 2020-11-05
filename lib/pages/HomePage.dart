import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mealhunt/pages/browse_page.dart';
import 'package:mealhunt/pages/meal_detail_page.dart';
import 'package:mealhunt/constants/api_endpoints.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("MealDB"),
          brightness: Brightness.light,
        ),
        body: Container(
//          color: Colors.white60,
          color: Colors.orange[100],
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  "The Meal DB",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 48,
//                backgroundColor: Colors.black87,
                  ),
                ),
              ),
              Image.asset("assets/images/food_image.jpeg"),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  child: Text(
                    "The Best place to pick your meal...",
                    style: TextStyle(
                      fontSize: 22,
                      wordSpacing: 5.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        elevation: 2,
                        splashColor: Colors.blue,
                        color: Colors.lightBlue,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BrowsePage(),
                              ));
                        },
                        child: Text("Browse"),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        elevation: 2,
                        splashColor: Colors.blue,
                        color: Colors.lightBlue,
                        onPressed: () {
                          String urlForsearchedMeal = searchMealByName;

                          TextEditingController searchMealFieldController =
                              new TextEditingController();
                          showDialog(
                              child: new Dialog(
                                backgroundColor: Colors.blue[100],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                elevation: 0,
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20.0, 20.0, 20.0, 20.0),
                                    child: new Column(
                                      children: <Widget>[
                                        Text(
                                          "Enter your meal",
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        new TextField(
                                          decoration: new InputDecoration(
                                            fillColor: Colors.blue,
                                            hintText: "Meal",
                                          ),
                                          controller: searchMealFieldController,
                                        ),
                                        new FlatButton(
                                          child: new Text(
                                            "Save",
                                          ),
                                          onPressed: () {
                                            String searchedText =
                                                searchMealFieldController.text;
                                            print("curr url " +urlForsearchedMeal);
                                            if (searchedText != "") {
                                              urlForsearchedMeal += searchedText;

                                              print("searched url is now " + urlForsearchedMeal);
                                              print("accepted text " +searchedText);


                                              Navigator.pop(context);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => MealDetailPage(
                                                      url: urlForsearchedMeal,
                                                    ),
                                                  ));
                                            } else {
                                              print("empty param");

                                            }

//                                            setState(() {
//                                              this._text = _c.text;
//                                            });
//                                        Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              context: context);
                        },
                        child: Text("Search"),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        elevation: 2,
                        splashColor: Colors.blue,
                        color: Colors.lightBlue,
                        onPressed: () {
                          String urlForRandomMeal = randomMeal;

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MealDetailPage(
                                  url: urlForRandomMeal,
                                ),
                              ));
                        },
                        child: Text("Surprise Me!"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

//  Future<http.Response> getRandomMeal(String url) async {
//    final response = await http.get(
//      url,
//      headers: {HttpHeaders.contentTypeHeader: "application/json"},
//    );
//  }
}
