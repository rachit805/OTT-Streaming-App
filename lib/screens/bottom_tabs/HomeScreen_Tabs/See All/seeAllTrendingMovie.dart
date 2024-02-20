import 'package:flutter/material.dart';
import 'package:ott/model/api.dart';
import 'package:ott/model/homeMoviesModel.dart';
import 'package:ott/model/kidsAnimeModel.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/kidsAnimeDetails.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/aboutMovieDetails.dart';
import 'package:ott/screens/widgets/shimmerLoadList.dart';
import 'package:ott/screens/widgets/shimmerLoadingGridView.dart';

class SeeAllTrendingMovie extends StatefulWidget {
  const SeeAllTrendingMovie({super.key});

  @override
  State<SeeAllTrendingMovie> createState() => _SeeAllTrendingMovieState();
}

class _SeeAllTrendingMovieState extends State<SeeAllTrendingMovie> {
  late Future<HomeMovies?> homeMovies;
  @override
  void initState() {
    super.initState();
    homeMovies = Api().fetchHomeMovies() as Future<HomeMovies?>;
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
      body: Center(
        child: FutureBuilder<HomeMovies?>(
          future: homeMovies,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return ShimmerLoadGridView();
            } else if (snapshot.hasData) {
              HomeMovies? homemovies = snapshot.data;

              if (homemovies == null) {
                return Center(
                  child: Text('Error: Received null data from the API.'),
                );
              }

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: homemovies.movies?.length ?? 0,
                  itemBuilder: (context, index) {
                    Movies? homemovielist = homemovies.movies?[index];
                    HomeMovies movies = homemovies;
                    // Images? image = track?.album?.images?[0];
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutMovieDetails(
                                        MoviePoster:
                                            homemovielist?.backdropPath ?? "",
                                        MovieName: homemovielist?.title ?? "",
                                        MovieId: homemovielist!.iId,
                                        MovieGenres:
                                            homemovielist?.genres ?? [],
                                        MovieOverview:
                                            homemovielist?.overview ?? "",
                                        MovieReleasedate:
                                            homemovielist?.releaseDate ?? "",
                                      )));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Builder(builder: (context) {
                              return Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.height *
                                        0.28,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        homemovielist?.posterPath ?? "",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: Text(
                                      homemovielist?.title ?? "",
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return ShimmerLoadListView();
            }
          },
        ),
      ),
    );
  }
}
