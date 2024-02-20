import 'package:flutter/material.dart';
import 'package:ott/model/anime.dart';
import 'package:ott/model/discoverMovies.dart';
import 'package:ott/model/movie.dart';
import 'package:ott/screens/widgets/constants.dart';

class AnimeDetail extends StatelessWidget {
  final Anime animedetail;

  AnimeDetail({
    required this.animedetail,
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
          "${animedetail.title}",
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
                      '${animedetail.image}',
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
                              'Status:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${animedetail.status}',
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
                              'Episodes:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${animedetail.episodes}',
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
                  Row(
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
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${animedetail.ranking}',
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
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Row(
                          children: [
                            Text(
                              'Genres:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Container(
                                child: Text(
                                  '${animedetail.genres}',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFF09047),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 80,
                        child: Text(
                          'Description:',
                          // textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.w100,
                              color: Colors.white),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '${animedetail.synopsis}',
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
