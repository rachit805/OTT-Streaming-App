import 'package:flutter/material.dart';
import 'package:ott/model/discoverMovies.dart';
import 'package:ott/model/movie.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/watchMovie.dart';
import 'package:ott/screens/widgets/constants.dart';

class MovieDetailScreen extends StatelessWidget {
  final DiscoverMovies discoverMovie;

  MovieDetailScreen({
    required this.discoverMovie,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFFF09047)),
        backgroundColor: Colors.black,
        title: Text(
          "${discoverMovie.title}",
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      '${Constants.imagePath}${discoverMovie.posterPath ?? ''}',
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WatchMovie(
                                  movieId: discoverMovie.id.toString(),
                                  movieName: discoverMovie.title.toString())));
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
                      child: const Center(
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
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // alignment: Alignment.topLeft,
                        // width: MediaQuery.of(context).size.width / 2,
                        child: Row(
                          children: [
                            Text(
                              'Language:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${discoverMovie.originalLanguage}',
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
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              'Views:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${discoverMovie.voteCount}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFF09047),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Popularity:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${discoverMovie.voteCount}',
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
                        alignment: Alignment.topLeft,
                        width: 80,
                        child: Text(
                          'Description:',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          '${discoverMovie.overview}',
                          // textAlign: TextAlign.center,
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
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
