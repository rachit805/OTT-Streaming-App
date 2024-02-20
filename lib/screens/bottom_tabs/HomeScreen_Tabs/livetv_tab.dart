import 'package:flutter/material.dart';
import 'package:ott/model/hindiTvshowModel.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/discoverTvShowDetail.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/tvShowDetails.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/See%20All/TvShows/seeAllWeekTopShow.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/See%20All/seeAllLiveTvShow.dart';
import 'package:ott/screens/widgets/constants.dart';
import 'package:ott/model/api.dart';
import 'package:ott/model/tvshow.dart';
import 'package:ott/screens/widgets/shimmerLoadList.dart';

class LiveTvTab extends StatefulWidget {
  const LiveTvTab({super.key});

  @override
  State<LiveTvTab> createState() => _LiveTvTabState();
}

class _LiveTvTabState extends State<LiveTvTab> {
  late Future<List<LiveTvShow>> Tvshows;

  @override
  void initState() {
    super.initState();
    Tvshows = Api().getLiveTvShow();
    Api().fetchHindiTvShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover English Shows',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeeAllLiveTvShow(),
                          ));
                    },
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: Color(0xFFF09047),
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          FutureBuilder(
            future: Tvshows,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                List<LiveTvShow> tvshow = snapshot.data as List<LiveTvShow>;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    height: 210,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: tvshow.length,
                      itemBuilder: (context, index) {
                        LiveTvShow tvShow = tvshow[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TvShowDetails(
                                    // liveTVShowDetail: tvShow,
                                    Id: tvShow.id.toString(),
                                    Name: tvShow.name.toString(),
                                  ),
                                ));
                          },
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Builder(builder: (context) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: 128.61,
                                    height: 160,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: Image.network(
                                      '${Constants.imagePath}${tvShow.posterPath ?? ''}',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              }),
                              // SizedBox(
                              //   height: 5,
                              // ),
                              Flexible(
                                child: Container(
                                  width: 128.61,
                                  child: Text(
                                    "${tvShow.name}",
                                    softWrap: true,
                                    style: TextStyle(
                                      color: Color(0xFFF09047),
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else {
                return ShimmerLoadListView();
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Weekly Top Shows',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeeAllWeekTopShow(),
                          ));
                    },
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: Color(0xFFF09047),
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: FutureBuilder<List<HindiTvShow>>(
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
                  return Container(
                    height: 210,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Builder(builder: (context) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: 128.61,
                                    height: 160,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: Image.network(
                                      '${Constants.imagePath}${tvShows[index].posterPath ?? ''}',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              }),
                              Flexible(
                                child: Container(
                                  width: 128.61,
                                  child: Text(
                                    tvShows[index].name,
                                    softWrap: true,
                                    style: TextStyle(
                                      color: Color(0xFFF09047),
                                      fontSize: 15,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // ListTile(
                          //   title: Text(
                          //     tvShows[index].name,
                          //     style: TextStyle(color: Colors.deepOrangeAccent),
                          //   ),
                          //   subtitle: Text(
                          //     tvShows[index].overview,
                          //     maxLines: 2,
                          //     overflow: TextOverflow.ellipsis,
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          //   leading: Image.network(
                          //     '${Constants.imagePath}${tvShows[index].posterPath ?? ''}',
                          //     fit: BoxFit.fill,
                          //   ),
                          // ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
