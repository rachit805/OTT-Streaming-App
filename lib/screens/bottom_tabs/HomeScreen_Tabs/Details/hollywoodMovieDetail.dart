import 'package:flutter/material.dart';
import 'package:ott/model/movie.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/watchMovie.dart';
import 'package:ott/screens/widgets/constants.dart';

class HollywoddMovieDetail extends StatelessWidget {
  const HollywoddMovieDetail({super.key, required this.hollywoodMovie});
  final Movie hollywoodMovie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFFF09047)),
        backgroundColor: Colors.black,
        title: Text(
          "${hollywoodMovie.title}",
          style: const TextStyle(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    '${Constants.imagePath}${hollywoodMovie.posterPath ?? ''}',
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
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
                          const Text(
                            'Language:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${hollywoodMovie.originalLanguage}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
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
                          const Text(
                            'Views:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${hollywoodMovie.voteCount}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
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
                          const Text(
                            'Popularity:',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${hollywoodMovie.popularity}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
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
                      // Container(
                      //   child:
                      // ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      'Release Date:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${hollywoodMovie.releaseDate}',
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFF09047),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 1,
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      child: const Text(
                        'Description:',
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            fontWeight: FontWeight.w100,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: Text(
                        '${hollywoodMovie.overview?.isNotEmpty == true ? hollywoodMovie.overview! : "Sorry, Overview is not Available"}',
                        softWrap: true,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10,
                          fontWeight: FontWeight.w100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WatchMovie(
                                movieId: hollywoodMovie.id.toString(),
                                movieName: hollywoodMovie.title.toString())));
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
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
