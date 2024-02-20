import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ott/model/api.dart';
import 'package:ott/model/hindiTvshowModel.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/demoSeasonData.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/tvShowDetails.dart';
import 'package:ott/screens/widgets/constants.dart';

class MyStuffScreen extends StatefulWidget {
  @override
  _MyStuffScreenState createState() => _MyStuffScreenState();
}

class _MyStuffScreenState extends State<MyStuffScreen> {
  @override
  void initState() {
    Api().fetchHindiTvShows();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<List<HindiTvShow>>(
        future: Api().fetchHindiTvShows(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Color(0xFFF09047),
            ));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<HindiTvShow> tvShows = snapshot.data!;
            return ListView.builder(
              itemCount: tvShows.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TvShowDetails(
                                  Id: tvShows[index].id.toString(),
                                  Name: tvShows[index].name,
                                )));
                  },
                  child: ListTile(
                    title: Text(
                      tvShows[index].name,
                      style: TextStyle(color: Colors.deepOrangeAccent),
                    ),
                    subtitle: Text(
                      tvShows[index].overview,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    ),
                    leading: Image.network(
                      '${Constants.imagePath}${tvShows[index].posterPath ?? ''}',
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
