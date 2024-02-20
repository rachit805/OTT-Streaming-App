import 'package:flutter/material.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/watchMovie.dart';
import 'package:ott/screens/widgets/constants.dart';
import 'package:ott/model/hindiMovie.dart';
import 'package:ott/model/movie.dart';

class HindiMovieDetail extends StatelessWidget {
  const HindiMovieDetail({super.key, required this.hindiMovie});
  final HindiMovie hindiMovie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFFF09047)),
        backgroundColor: Colors.black,
        title: Text(
          "${hindiMovie.title}",
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
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        '${Constants.imagePath}${hindiMovie.posterPath ?? ''}',
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                                '${hindiMovie.originalLanguage}',
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
                                '${hindiMovie.voteCount}',
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
                      // width: MediaQuery.of(context).size.width / 2,
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
                                width: 3,
                              ),
                              Text(
                                '${hindiMovie.popularity}',
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
                          // SizedBox(
                          //   width: 40,
                          // ),
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  'Release Date:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  '${hindiMovie.releaseDate}',
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
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
                            'Description:',
                            // textAlign: TextAlign.center,
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
                            '${hindiMovie.overview?.isNotEmpty == true ? hindiMovie.overview! : "Sorry, Currently overview is not Available!"}',
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WatchMovie(
                                      movieId: hindiMovie.id.toString(),
                                      movieName: hindiMovie.title.toString(),
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
          ),
        ],
      ),
    );
  }
}
