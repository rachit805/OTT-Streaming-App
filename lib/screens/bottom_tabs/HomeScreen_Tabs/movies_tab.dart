import 'package:flutter/material.dart';
import 'package:ott/model/homeMoviesModel.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/discoverMovieDetail.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/bollywoodMovieDetails.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/hollywoodMovieDetail.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/aboutMovieDetails.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/See%20All/seeAllDiscoverMovie.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/See%20All/seeAllHindiMovie.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/See%20All/seeAllHollywoodMovie.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/See%20All/seeAllTrendingMovie.dart';
import 'package:ott/screens/widgets/constants.dart';
import 'package:ott/model/api.dart';
import 'package:ott/model/discoverMovies.dart';
import 'package:ott/model/hindiMovie.dart';
import 'package:ott/model/movie.dart';
import 'package:ott/screens/widgets/shimmerLoadList.dart';
import 'package:shimmer/shimmer.dart';

class MoviesTab extends StatefulWidget {
  const MoviesTab({Key? key}) : super(key: key);

  @override
  State<MoviesTab> createState() => _MoviesTabState();
}

class _MoviesTabState extends State<MoviesTab> {
  // DiscoverMovies? discovermovies;

  late Future<List<Movie>> trendingMovies;
  late Future<List<DiscoverMovies>> discoverMovies;
  late Future<List<HindiMovie>> hindiMovie;
  late Future<HomeMovies?> homeMovies;
  late Future<List<HindiMovie>> hindiMovie2;

  @override
  void initState() {
    trendingMovies = Api().getTrendingMovies();
    discoverMovies = Api().getDiscoverMovies();
    hindiMovie = Api().getHindiMovie();
    homeMovies = Api().fetchHomeMovies() as Future<HomeMovies?>;
    hindiMovie2 = Api().getHindiMovies2();

    super.initState();
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
                    'Trending Movies',
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
                          builder: (context) => SeeAllTrendingMovie(),
                        ),
                      );
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
          FutureBuilder<HomeMovies?>(
            future: homeMovies,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return ShimmerLoadListView();
              } else if (snapshot.hasData) {
                HomeMovies? homemovies = snapshot.data;

                if (homemovies == null) {
                  return Center(
                    child: Text('Error: Received null data from the API.'),
                  );
                }

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Container(
                        height: 175,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
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
                                          builder: (context) =>
                                              AboutMovieDetails(
                                                MoviePoster: homemovielist
                                                        ?.backdropPath ??
                                                    "",
                                                MovieName:
                                                    homemovielist?.title ?? "",
                                                MovieId: homemovielist!.iId,
                                                MovieGenres:
                                                    homemovielist?.genres ?? [],
                                                MovieOverview:
                                                    homemovielist?.overview ??
                                                        "",
                                                MovieReleasedate: homemovielist
                                                        ?.releaseDate ??
                                                    "",
                                              )));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Builder(builder: (context) {
                                      return Column(
                                        children: [
                                          // Text(),
                                          Container(
                                            width: 128.61,
                                            height: 150,
                                            child: Image.network(
                                              homemovielist?.posterPath ?? "",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Container(
                                            width: 128.61,
                                            child: Text(
                                              homemovielist?.title ?? "",
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Color(0xFFF09047),
                                                fontSize: 15,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w600,
                                              ),
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
                      ),
                    ],
                  ),
                );
              } else {
                return ShimmerLoadListView();
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover Movies',
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
                          builder: (context) => SeeAllDiscoverMovie(),
                        ),
                      );
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
            future: discoverMovies,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                List<DiscoverMovies> movies =
                    snapshot.data as List<DiscoverMovies>;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    height: 170,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        DiscoverMovies discovermovies = movies[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailScreen(
                                  discoverMovie: discovermovies,
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
                                    width: 128.61,
                                    height: 150,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: Image.network(
                                      '${Constants.imagePath}${discovermovies.posterPath ?? ''}',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              }),
                              Flexible(
                                child: Container(
                                  width: 128.61,
                                  child: Text(
                                    "${discovermovies.title}",
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
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
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hollywood Movies',
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
                            builder: (context) => SellAllHollywoodMovie(),
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
            future: trendingMovies,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                List<Movie> movies = snapshot.data as List<Movie>;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    height: 180, // Set a fixed height or adjust as needed
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        Movie movie = movies[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HollywoddMovieDetail(
                                  hollywoodMovie: movie,
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
                                    width: 128.61,
                                    height: 150,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: Image.network(
                                      '${Constants.imagePath}${movie.posterPath ?? ''}',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              }),
                              SizedBox(
                                height: 5,
                              ),
                              Flexible(
                                child: Container(
                                  width: 128.61,
                                  child: Text(
                                    "${movie.title}",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
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
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bollywood Movies',
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
                            builder: (context) => SeeAllBollywoodMovie(
                              hindiMovie: hindiMovie2,
                            ),
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
            future: hindiMovie2,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                List<HindiMovie> hindimovie = snapshot.data as List<HindiMovie>;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    height: 190,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: hindimovie.length,
                      itemBuilder: (context, index) {
                        HindiMovie hindiMovie = hindimovie[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HindiMovieDetail(
                                    hindiMovie: hindiMovie,
                                  ),
                                ));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Builder(builder: (context) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: 128.61,
                                    height: 150,
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: Image.network(
                                      '${Constants.imagePath}${hindiMovie.posterPath ?? ''}',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              }),
                              Flexible(
                                child: Container(
                                  width: 128.61,
                                  child: Text(
                                    "${hindiMovie.title}",
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
            height: 80,
          )
        ],
      ),
    );
  }
}
