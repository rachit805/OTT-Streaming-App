import 'package:flutter/material.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/discoverMovieDetail.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/discoverTvShowDetail.dart';
import 'package:ott/screens/widgets/constants.dart';
import 'package:ott/model/api.dart';
import 'package:ott/model/discoverMovies.dart';
import 'package:ott/model/tvshow.dart';
import 'package:ott/screens/widgets/shimmerLoadingGridView.dart';
import 'package:shimmer/shimmer.dart';

class SeeAllLiveTvShow extends StatefulWidget {
  const SeeAllLiveTvShow({super.key});

  @override
  State<SeeAllLiveTvShow> createState() => _SeeAllLiveTvShowState();
}

class _SeeAllLiveTvShowState extends State<SeeAllLiveTvShow> {
  late Future<List<LiveTvShow>> liveTvShow;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    liveTvShow = Api().getLiveTvShow();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFFF09047),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     Icons.search,
            //     color: Colors.white,
            //   ),
            // ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: liveTvShow,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            List<LiveTvShow> liveshow = snapshot.data as List<LiveTvShow>;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: liveshow.length,
                itemBuilder: (context, index) {
                  LiveTvShow liveTvShow = liveshow[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LiveTvShowDetail(
                            liveTVShowDetail: liveTvShow,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Builder(builder: (context) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Image.network(
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Shimmer.fromColors(
                                        baseColor: Colors.black,
                                        highlightColor: Colors.white12,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                          color: Colors.white54,
                                        ));
                                  }
                                },
                                '${Constants.imagePath}${liveTvShow.posterPath ?? ''}',
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return ShimmerLoadGridView();
          }
        },
      ),
    );
  }
}
