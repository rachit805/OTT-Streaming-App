import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ott/model/downloadMovie.dart';
import 'package:ott/model/movie.dart';
import 'package:ott/model/spotify-services.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/playMusicScreen.dart';
import 'package:http/http.dart' as http;

class ChannelScreenTab extends StatefulWidget {
  const ChannelScreenTab({Key? key}) : super(key: key);

  @override
  State<ChannelScreenTab> createState() => _ChannelScreenTabState();
}

class _ChannelScreenTabState extends State<ChannelScreenTab> {
  late Future<Map<String, dynamic>> top50bollywodmusicPlaylist;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<DownloadableMovies>> fetchData() async {
    const String apiUrl =
        'https://stoplight.io/mocks/bisoncorps/gophie/985190/list?page=2';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Accept': 'application/json, application/xml, multipart/form-data'
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        List<DownloadableMovies> movies =
            jsonData.map((data) => DownloadableMovies.fromJson(data)).toList();

        print(movies);
        print("rachit");
        return movies;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black, body: Column());
  }
}
