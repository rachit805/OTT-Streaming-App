// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:marquee/marquee.dart';
// import 'package:ott/model/tvShowDetailsModel.dart';
// import 'package:ott/model/hindiTvshowModel.dart';
// import 'package:http/http.dart' as http;
// import 'package:ott/screens/widgets/constants.dart';
// import 'package:palette_generator/palette_generator.dart';
// import 'package:ott/model/tvShowDetailsModel.dart';

// class TvShowDetails extends StatefulWidget {
//   const TvShowDetails({
//     Key? key,
//     required this.Id,
//     required this.Name,
//   }) : super(key: key);

//   final String Id;
//   final String Name;

//   @override
//   State<TvShowDetails> createState() => _TvShowDetailsState();
// }

// class _TvShowDetailsState extends State<TvShowDetails>
//     with SingleTickerProviderStateMixin {
//   PaletteGenerator? _paletteGenerator;
//   late TabController? _tabController;
//   late Future<TvShowsDetails> _tvShowDetailsFuture;

//   Future<void> _generatePalette(String imagePath) async {
//     final PaletteGenerator paletteGenerator =
//         await PaletteGenerator.fromImageProvider(
//       NetworkImage(imagePath),
//       size: Size(100, 100),
//     );

//     setState(() {
//       _paletteGenerator = paletteGenerator;
//     });
//   }

//   Future<TvShowsDetails> fetchTvShowDetails() async {
//     final response = await http.get(
//       Uri.parse('https://api.themoviedb.org/3/tv/${widget.Id}'),
//       headers: {
//         'Authorization':
//             'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZTBhN2Q2MTkyNmVkNzUyOGI4OWYyYWZhMDFhODgzMyIsInN1YiI6IjY1YTc5MDMxNTI5NGU3MDEyNGQyYzk1OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Y7dN4W8E35HTmnSRwqpvRpBFgjB8JyUvJy7koVuo9S4',
//         'accept': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> results = json.decode(response.body);
//       print(results);

//       return TvShowsDetails.fromJson(results);
//     } else {
//       throw Exception('Failed to load Hindi TV shows');
//     }
//   }

//   int getEpisodeCountForSeason(List<Seasons> seasons, int seasonNumber) {
//     for (var season in seasons) {
//       if (season.seasonNumber == seasonNumber) {
//         return season.episodeCount ?? 0;
//       }
//     }
//     return 0;
//   }

//   String getSeasonsOverview(List<Seasons> seasons, String seasonOverview) {
//     for (var season in seasons) {
//       if (season.overview == seasonOverview) {
//         return season.overview.toString();
//       }
//     }
//     return seasonOverview;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _tvShowDetailsFuture = fetchTvShowDetails();
//     _tvShowDetailsFuture.then((show) {
//       setState(() {
//         _tabController = TabController(
//           length: show.numberOfSeasons ?? 1,
//           vsync: this,
//         );
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Color(0xFFF09047)),
//         backgroundColor: Colors.black,
//         title: Container(
//           height: kToolbarHeight,
//           child: Row(
//             children: [
//               Expanded(
//                 child: Marquee(
//                   text: widget.Name,
//                   style: TextStyle(
//                     color: Color(0xFFF09047),
//                     fontWeight: FontWeight.w500,
//                   ),
//                   scrollAxis: Axis.horizontal,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   blankSpace: MediaQuery.of(context).size.width,
//                   velocity: 80.0,
//                   pauseAfterRound: Duration(seconds: 1),
//                   startPadding: 5,
//                   accelerationDuration: Duration(seconds: 2),
//                   accelerationCurve: Curves.linear,
//                 ),
//               ),
//               Container(
//                 color: Colors.black,
//               ),
//             ],
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: FutureBuilder(
//           future: _tvShowDetailsFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(
//                   color: Color(0xFFF09047),
//                 ),
//               );
//             } else if (snapshot.hasError) {
//               return Text("Error: ${snapshot.error}");
//             } else {
//               TvShowsDetails? show = snapshot.data as TvShowsDetails?;
//               final String imagePath =
//                   "${Constants.imagePath}${show?.backdropPath}";

//               if (_paletteGenerator == null) {
//                 _generatePalette(imagePath);
//               }
//               return ListView(
//                 children: [
//                   Container(
//                     height: MediaQuery.of(context).size.height / 3,
//                     decoration: BoxDecoration(
//                       color: _paletteGenerator?.dominantColor?.color ??
//                           Colors.black,
//                       image: DecorationImage(
//                         image: NetworkImage(imagePath),
//                         fit: BoxFit.fill,
//                         colorFilter: ColorFilter.mode(
//                           Colors.black
//                               .withOpacity(0.6), // Adjust opacity as needed
//                           BlendMode.srcOver,
//                         ),
//                       ),
//                     ),
//                     // ... existing code
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: DefaultTabController(
//                       length: _tabController?.length ?? 1,
//                       child: Column(
//                         children: [
//                           TabBar(
//                             controller: _tabController,
//                             isScrollable: true,
//                             indicator: BoxDecoration(),
//                             tabs: List.generate(
//                               _tabController?.length ?? 1,
//                               (index) {
//                                 return Container(
//                                   width: 100,
//                                   padding: EdgeInsets.all(8.0),
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.rectangle,
//                                     border:
//                                         Border.all(color: Color(0xFFF09047)),
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       "Season ${(index + 1)}",
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         fontFamily: 'Inter',
//                                         fontWeight: FontWeight.w800,
//                                         color: Color(0xFFF09047),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                           Container(
//                             height: 200,
//                             child: TabBarView(
//                               controller: _tabController,
//                               children: List.generate(
//                                 _tabController?.length ?? 1,
//                                 (index) {
//                                   int seasonNumber = index + 1;
//                                   int episodeCount = getEpisodeCountForSeason(
//                                       show?.seasons ?? [], seasonNumber);
//                                   return Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "Episodes for Season $seasonNumber",
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                       SizedBox(height: 10),
//                                       Wrap(
//                                         children: List.generate(
//                                           episodeCount,
//                                           (index) => Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 10, right: 5, bottom: 10),
//                                             child: Container(
//                                               width: 55,
//                                               padding: EdgeInsets.all(8.0),
//                                               decoration: BoxDecoration(
//                                                 shape: BoxShape.rectangle,
//                                                 border: Border.all(
//                                                     color: Color(0xFFF09047)),
//                                                 borderRadius:
//                                                     BorderRadius.circular(15),
//                                               ),
//                                               child: Center(
//                                                 child: Text(
//                                                   (episodeCount - index)
//                                                       .toString(),
//                                                   style: TextStyle(
//                                                     fontSize: 15,
//                                                     fontFamily: 'Inter',
//                                                     fontWeight: FontWeight.w800,
//                                                     color: Color(0xFFF09047),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // ... remaining code
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildGenreContainer(String genre) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 5),
//       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(
//         border: Border.all(color: Color(0xFFF09047)),
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Text(
//         genre,
//         style: TextStyle(
//           fontSize: 11,
//           fontFamily: 'Inter',
//           fontWeight: FontWeight.w600,
//           color: Color(0xFFF09047),
//         ),
//       ),
//     );
//   }
// }
