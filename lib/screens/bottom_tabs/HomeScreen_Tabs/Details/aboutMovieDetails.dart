import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/watchMovie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ott/model/homeMoviesModel.dart';
import 'package:ott/model/movieDetailsModel.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/aboutMovieDetails.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class AboutMovieDetails extends StatefulWidget {
  const AboutMovieDetails({
    Key? key,
    required this.MoviePoster,
    required this.MovieName,
    required this.MovieGenres,
    required this.MovieOverview,
    required this.MovieReleasedate,
    required this.MovieId,
  }) : super(key: key);

  final String MoviePoster;
  final String MovieName;
  final MovieId;
  final List<String> MovieGenres;
  final String MovieReleasedate;
  final String MovieOverview;

  @override
  State<AboutMovieDetails> createState() => _AboutMovieDetailsState();
}

class _AboutMovieDetailsState extends State<AboutMovieDetails> {
  late dynamic movieId;
  late Future<MovieDetails> movieDetail;
  //  late MovieDetails? movieDetails;

  @override
  void initState() {
    super.initState();
    movieId = widget.MovieId;
    fetchMovieDetails();
    loadBookmarkedState();
    // fetchData();
  }

  // Future<List<dynamic>> fetchData() async {
  //   const String apiUrl =
  //       'https://stoplight.io/mocks/bisoncorps/gophie/985190/list?page=1';

  //   try {
  //     final response = await http.get(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Accept': 'application/json, application/xml, multipart/form-data'
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       // If server returns an OK response, parse the JSON
  //       List<dynamic> data = json.decode(response.body);
  //       print(data);
  //       print("rachit");
  //       return data;
  //     } else {
  //       // If the server did not return a 200 OK response,
  //       // throw an exception.
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (e) {
  //     // Handle network errors or other exceptions
  //     print('Error: $e');
  //     throw Exception('Failed to fetch data');
  //   }
  // }

  Future<MovieDetails?> fetchMovieDetails() async {
    final String apiUrl = 'https://movies-api14.p.rapidapi.com/movie/$movieId';

    final Map<String, String> headers = {
      'X-RapidAPI-Key': '07d8bf7097msh8f9cb56468126ecp175423jsnadc0ab24f5d1',
      'X-RapidAPI-Host': 'movies-api14.p.rapidapi.com',
    };

    try {
      final http.Response response =
          await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print(jsonResponse);

        final movieDetails = MovieDetails.fromJson(jsonResponse);
        print(movieDetails.movie?.youtubeTrailer);

        return movieDetails;
      } else {
        print('Failed to fetch data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error during API request: $error');
      return null;
    }
  }

  Future<void> _downloadVideo(String videoId, String videoTitle) async {
    try {
      var ytExplode = YoutubeExplode();
      var video = await ytExplode.videos.get(videoId);
      var manifest = await ytExplode.videos.streamsClient.getManifest(video);

      var videoStream = manifest.video.first;
      var audioStream = manifest.audioOnly.first;

      var videoFile = await ytExplode.videos.streamsClient.get(videoStream);

      await _saveVideo(videoFile as File, '$videoTitle');
      ytExplode.close();
    } catch (error) {
      print('Error downloading video: $error');
    }
  }

  Future<void> _saveVideo(File videoFile, String videoTitle) async {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final savePath = appDocDir.path + '/$videoTitle.mp4';

      final videoBytes = await videoFile.readAsBytes();
      final File file = File(savePath);

      await file.writeAsBytes(videoBytes);

      print('Video saved successfully to: $savePath');
    } catch (error) {
      print('Error saving video: $error');
    }
  }

  late bool isBookmarked = false;
  Future<void> loadBookmarkedState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isBookmarked = prefs.getBool('isBookmarked_$movieId') ?? false;
    });
  }

  Future<void> saveBookmarkedState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isBookmarked_$movieId', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFFF09047)),
        backgroundColor: Colors.black,
        title: Text(
          widget.MovieName,
          style: TextStyle(
            color: Color(0xFFF09047),
            fontSize: 25,
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Image.network(
                          widget.MoviePoster,
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return Stack(
                                children: [
                                  child,
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isBookmarked = !isBookmarked;
                                          saveBookmarkedState(isBookmarked);
                                        });
                                      },
                                      child: Icon(
                                        isBookmarked
                                            ? Icons.bookmark_added
                                            : Icons.bookmark_add,
                                        color: isBookmarked
                                            ? Color(0xFFF09047)
                                            : Colors.white,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Center(
                                child: ShimmerLoadPlayer(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          child: Text(
                            'Genres:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: widget.MovieGenres.map(
                                (genre) => _buildGenreContainer(genre),
                              ).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Release Date:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              widget.MovieReleasedate,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFF09047),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                'Movie ID:',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                widget.MovieId.toString(),
                                textAlign: TextAlign.center,
                                softWrap: true,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFF09047),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 80,
                        child: Text(
                          'Overview:',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          widget.MovieOverview,
                          softWrap: true,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 10,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder<MovieDetails?>(
            future: fetchMovieDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ShimmerLoadPlayer();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                MovieDetails? movieDetails = snapshot.data;

                String? youtubeVideoId = movieDetails?.movie?.youtubeTrailer;

                if (youtubeVideoId != null) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: YoutubePlayer(
                      controller: YoutubePlayerController(
                        initialVideoId:
                            YoutubePlayer.convertUrlToId(youtubeVideoId) ?? '',
                        flags: YoutubePlayerFlags(
                          autoPlay: false,
                          mute: false,
                        ),
                      ),
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.amber,
                    ),
                  );
                } else {
                  return Center(
                    child: Text('No YouTube video available'),
                  );
                }
              } else {
                return Center(
                  child: Text('No data available'),
                );
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
              onTap: () {
                String? videoId = MovieDetails().movie?.youtubeTrailer;
                if (videoId!.isNotEmpty) {
                  _downloadVideo(videoId, widget.MovieName);
                } else {
                  print('No YouTube video available for download');
                }
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Download Trailer",
                        style: TextStyle(color: Color(0xFFF09047)),
                      ),
                      Icon(
                        Icons.download,
                        color: Color(0xFFF09047),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WatchMovie(
                              movieId: widget.MovieId.toString(),
                              movieName: widget.MovieName,
                            )));
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Watch Movie (1080p)",
                        style: TextStyle(
                            color: Color(0xFFF09047),
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.play_circle_fill,
                        size: 25,
                        color: Color(0xFFF09047),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildGenreContainer(String genre) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      border: Border.all(color: Color(0xFFF09047)),
      borderRadius: BorderRadius.circular(15),
    ),
    child: Text(
      genre,
      style: TextStyle(
        fontSize: 11,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        color: Color(0xFFF09047),
      ),
    ),
  );
}

class ShimmerLoadPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Shimmer.fromColors(
              baseColor: Colors.black!,
              highlightColor: Colors.white!,
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class BookmarkedModel extends ChangeNotifier {
//   late bool _isBookmarked;
//   BookmarkedModel(this._isBookmarked);
//   bool get isBookmarked => _isBookmarked;

//   void toggleBookmarked() {
//     _isBookmarked = !_isBookmarked;
//     notifyListeners();
//   }
// }
