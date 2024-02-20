import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:ott/model/tvShowDetailsModel.dart';
import 'package:ott/model/hindiTvshowModel.dart';
import 'package:http/http.dart' as http;
import 'package:ott/screens/widgets/constants.dart';
import 'package:palette_generator/palette_generator.dart';

class TvShowDetails extends StatefulWidget {
  const TvShowDetails({
    super.key,
    required this.Id,
    required this.Name,
  });
  final String Id;
  final String Name;
  @override
  State<TvShowDetails> createState() => _TvShowDetailsState();
}

class _TvShowDetailsState extends State<TvShowDetails> {
  PaletteGenerator? _paletteGenerator;

  Future<void> _generatePalette(String imagePath) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      NetworkImage(imagePath),
      size: Size(100, 100),
    );

    setState(() {
      _paletteGenerator = paletteGenerator;
    });
  }

  Future<TvShowsDetails> fetchTvShowDetails() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/tv/${widget.Id}'),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZTBhN2Q2MTkyNmVkNzUyOGI4OWYyYWZhMDFhODgzMyIsInN1YiI6IjY1YTc5MDMxNTI5NGU3MDEyNGQyYzk1OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Y7dN4W8E35HTmnSRwqpvRpBFgjB8JyUvJy7koVuo9S4',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> results = json.decode(response.body);
      print(results);

      return TvShowsDetails.fromJson(results);
    } else {
      throw Exception('Failed to load Hindi TV shows');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTvShowDetails();
    print(widget.Id);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFF09047)),
        backgroundColor: Colors.black,
        title: Container(
          height: kToolbarHeight,
          child: Row(
            children: [
              Expanded(
                child: Marquee(
                  text: widget.Name,
                  style: TextStyle(
                    color: Color(0xFFF09047),
                    fontWeight: FontWeight.w500,
                  ),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: MediaQuery.of(context).size.width,
                  velocity: 80.0,
                  pauseAfterRound: Duration(seconds: 1),
                  startPadding: 5,
                  accelerationDuration: Duration(seconds: 2),
                  accelerationCurve: Curves.linear,
                ),
              ),
              Container(
                color: Colors.black,
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: fetchTvShowDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFF09047),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              TvShowsDetails? show = snapshot.data;
              final String imagePath =
                  "${Constants.imagePath}${show?.backdropPath}";

              if (_paletteGenerator == null) {
                _generatePalette(imagePath);
              }
              return ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      color: _paletteGenerator?.dominantColor?.color ??
                          Colors.black,
                      image: DecorationImage(
                        image: NetworkImage(imagePath),
                        fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(
                          Colors.black
                              .withOpacity(0.7), // Adjust opacity as needed
                          BlendMode.srcOver,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 4,
                          width: MediaQuery.of(context).size.width / 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              "${Constants.imagePath}${show?.posterPath}",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          width: 200,
                          height: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Language:",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    show!.spokenLanguages![0].name!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Country:",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    show.originCountry.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    "Start Date:",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    show.firstAirDate.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Last Episode:",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    show.lastAirDate.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  )
                                ],
                              ),
                              Container(
                                child: Text(
                                  "Overview:",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              Text(
                                "${show?.overview}",
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            width: 70,
                            child: Text(
                              'Genres:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
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
                                children: show.genres!.map((genre) {
                                  return _buildGenreContainer(genre.name!);
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white54),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    'Seasons:',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: IntrinsicWidth(
                                    child: Wrap(
                                      children: List.generate(
                                        show.numberOfSeasons != null
                                            ? show.numberOfSeasons!
                                            : 0,
                                        (index) => GestureDetector(
                                          onTap: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 5, bottom: 10),
                                            child: Container(
                                              width: 100,
                                              padding: EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    color: Color(0xFFF09047)),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Season ${(index + 1)}",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w800,
                                                    color: Color(0xFFF09047),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    'Episodes:',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: IntrinsicWidth(
                                    child: Wrap(
                                      children: List.generate(
                                        show.seasons![0].episodeCount != null
                                            ? show.seasons!.length
                                            : 0,
                                        (index) => GestureDetector(
                                          onTap: () {
                                            print(show
                                                .seasons![index].episodeCount
                                                .toString());
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 5, bottom: 10),
                                            child: Container(
                                              width: 55,
                                              padding: EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.rectangle,
                                                border: Border.all(
                                                    color: Color(0xFFF09047)),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  (show.seasons![index]
                                                              .episodeCount! -
                                                          index)
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w800,
                                                    color: Color(0xFFF09047),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    'Overview:',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                // Flexible(
                                //   child: Text(
                                //     show.seasons![2].overview!,
                                //     // maxLines: 3,
                                //     // overflow: TextOverflow.ellipsis,
                                //     style: TextStyle(
                                //       fontSize: 10,
                                //       fontFamily: 'Inter',
                                //       fontWeight: FontWeight.w800,
                                //       color: Colors.white,
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
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
}
