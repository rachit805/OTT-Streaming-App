import 'package:flutter/material.dart';
import 'package:ott/screens/widgets/constants.dart';
import 'package:ott/model/hindiMovie.dart';
import 'package:ott/model/movie.dart';
import 'package:ott/model/tvshow.dart';

class LiveTvShowDetail extends StatelessWidget {
  const LiveTvShowDetail({super.key, required this.liveTVShowDetail});
  final LiveTvShow liveTVShowDetail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFFF09047)),
        backgroundColor: Colors.black,
        title: Text(
          "${liveTVShowDetail.name}",
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
          Container(
            height: 30,
            decoration: BoxDecoration(color: Colors.redAccent),
            alignment: Alignment.center,
            child: Text(
              "Sorry, Currently Video is not available!",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
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
                      '${Constants.imagePath}${liveTVShowDetail.posterPath ?? ''}',
                      // fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Language:',
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
                            '${liveTVShowDetail.originalLanguage}',
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
                              'Views:',
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
                              '${liveTVShowDetail.voteCount}',
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
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${liveTVShowDetail.popularity}',
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
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${liveTVShowDetail.firstAirDate}',
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
                          '${liveTVShowDetail.overview}',
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
