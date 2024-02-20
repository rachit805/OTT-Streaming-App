import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ott/screens/widgets/constants.dart';

class SearchMulti extends StatefulWidget {
  const SearchMulti({super.key});

  @override
  State<SearchMulti> createState() => _SearchMultiState();
}

class _SearchMultiState extends State<SearchMulti> {
  @override
  bool showList = false;
  var vall;
  TextEditingController searchText = TextEditingController();
  List<Map<String, dynamic>> searchResult = [];

  Future<void> searchListFunction(String val) async {
    var searchUrl =
        "https://api.themoviedb.org/3/search/multi?api_key=$Constants.apiKey&query=$val";
    var searchResponse = await http.get(Uri.parse(searchUrl));
    if (searchResponse.statusCode == 200) {
      var tempData = jsonDecode(searchResponse.body);
      var searchJson = tempData["result"];

      for (var item in searchJson) {
        if (item['id'] != null &&
            item['poster_path'] != null &&
            item['vote_average'] != null &&
            item['media_type'] != null) {
          searchResult.add({
            'id': item['id'],
            'poster_path': item['poster_path'],
            'vote_average': item['vote_average'],
            'media_type': item['media_type'],
            'overview': item['overview'],
            'popularity': item['popularity'],
          });
          if (searchResult.length > 20) {
            searchResult.removeRange(20, searchResult.length);
          }
        } else {
          print("Null Value Found");
        }
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          showList = !showList;
        },
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  controller: searchText,
                  autofocus: false,
                  onSubmitted: (value) {
                    searchResult.clear();
                    setState(() {
                      vall = value;
                    });
                  },
                  onChanged: (value) {
                    searchResult.clear();
                    setState(() {
                      vall = value;
                    });
                  },
                  decoration: InputDecoration(
                    suffix: IconButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: 'Search Cleared', webPosition: "center");
                          setState(() {
                            searchText.clear();
                            FocusManager.instance.primaryFocus?.unfocus();
                          });
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.amber,
                        )),
                    prefix: Icon(
                      Icons.search,
                      color: Colors.amber,
                    ),
                    hintText: "search",
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
