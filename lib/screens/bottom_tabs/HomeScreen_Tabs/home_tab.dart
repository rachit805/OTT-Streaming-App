import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ott/model/anime.dart';
import 'package:ott/model/api.dart';
import 'package:ott/model/bollywoodmusic.dart';
import 'package:ott/model/discoverMovies.dart';
import 'package:ott/model/featuredPlaylists.dart';
import 'package:ott/model/hindiMovie.dart';
import 'package:ott/model/hindiTvshowModel.dart';
import 'package:ott/model/hollywoodmusic.dart';
import 'package:ott/model/homeMoviesModel.dart';
import 'package:ott/model/movie.dart';
import 'package:ott/model/kidsAnimeModel.dart';
import 'package:ott/model/spotify-services.dart';
import 'package:ott/model/tvshow.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/TvShowDetails.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/animeDetail.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/discoverMovieDetail.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/bollywoodMovieDetails.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/hollywoodMovieDetail.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/hollywoodMusicDetail.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/kidsAnimeDetails.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/discoverTvShowDetail.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/aboutMovieDetails.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/See%20All/SeeAllAnime.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/featuredPlaylistDetails.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/See%20All/TvShows/seeAllWeekTopShow.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/See%20All/seeAllBollywoodMusic.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/See%20All/seeAllDiscoverMovie.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/See%20All/seeAllHindiMovie.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/See%20All/seeAllHollywoodMovie.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/See%20All/seeAllHollywoodMusic.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/See%20All/seeAllKidsAnime.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/See%20All/seeAllLiveTvShow.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/See%20All/seeAllTrendingMovie.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/kids_tab.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/movies_tab.dart';
import 'package:ott/screens/widgets/constants.dart';
import 'package:ott/screens/widgets/shimmerLoadList.dart';
import 'package:shimmer/shimmer.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<String> imagePaths1 = [
    "assets/images/T1.png",
    "assets/images/T2.png",
    "assets/images/T3.png",
    "assets/images/T1.png",
  ];
  List<String> imagePaths2 = [
    "assets/images/c1.png",
    "assets/images/c2.png",
    "assets/images/c3.png",
    "assets/images/c1.png",
  ];
  List<String> imagePaths3 = [
    "assets/images/d1.png",
    "assets/images/d2.png",
    "assets/images/d3.png",
    "assets/images/d1.png",
  ];
  List<String> imagePaths4 = [
    "assets/images/e1.png",
    "assets/images/e2.png",
    "assets/images/e3.png",
    "assets/images/e1.png",
  ];
  List<String> imagePaths5 = [
    "assets/images/f1.png",
    "assets/images/f2.png",
    "assets/images/f3.png",
    "assets/images/f1.png",
  ];
  List<String> imagePaths6 = [
    "assets/images/g1.png",
    "assets/images/g2.png",
    "assets/images/g3.png",
    "assets/images/g1.png",
  ];
  List<String> imagePaths7 = [
    "assets/images/h1.png",
    "assets/images/h2.png",
    "assets/images/h3.png",
    "assets/images/h1.png",
  ];
  List<String> imagePaths8 = [
    "assets/images/i1.png",
    "assets/images/i2.png",
    "assets/images/i3.png",
    "assets/images/i1.png",
  ];
  List<String> imagePaths9 = [
    "assets/images/j1.png",
    "assets/images/j2.png",
    "assets/images/j3.png",
    "assets/images/j1.png",
  ];
  List<String> imagePaths10 = [
    "assets/images/k1.png",
    "assets/images/k2.png",
    "assets/images/k3.png",
    "assets/images/k1.png",
  ];
  List<String> imagePaths11 = [
    "assets/images/c1.png",
    "assets/images/c2.png",
    "assets/images/c3.png",
    "assets/images/c1.png",
  ];
  List<String> imagePaths12 = [
    "assets/images/l1.png",
    "assets/images/l2.png",
    "assets/images/l3.png",
    "assets/images/l1.png",
  ];
  List<String> imagePaths13 = [
    "assets/images/m1.png",
    "assets/images/m2.png",
    "assets/images/m3.png",
    "assets/images/m1.png",
  ];
  List<String> imagePaths14 = [
    "assets/images/c1.png",
    "assets/images/c2.png",
    "assets/images/c3.png",
    "assets/images/c1.png",
  ];

  late Future<List<Movie>> trendingMovies;
  late Future<List<DiscoverMovies>> discoverMovies;
  late Future<List<HindiMovie>> hindiMovie2;
  late Future<List<LiveTvShow>> Tvshows;
  late Future<List<KidsAnimeModel>> kidsAnime;
  late Future<List<ChartEntry>> bollywoodMusic;
  late Future<List<HollywoodMusic>> hollywoodMusicList;
  late Future<List<Anime>> animeTab;
  late Future<FeaturedPlaylists?> featuredPlaylists;
  late Future<HomeMovies?> homeMovies;

  @override
  void initState() {
    trendingMovies = Api().getTrendingMovies();
    discoverMovies = Api().getDiscoverMovies();
    hindiMovie2 = Api().getHindiMovies2();
    Tvshows = Api().getLiveTvShow();
    kidsAnime = Api().fetchKidsAnimeData();
    bollywoodMusic = Api().getBollywoodMusicData();
    hollywoodMusicList = Api().fetchHollywoodMusicData();
    animeTab = Api().fetchAnimeData();
    featuredPlaylists = SpotifyService().fetchFeaturedPlaylists();
    homeMovies = Api().fetchHomeMovies() as Future<HomeMovies?>;

    // Api().fetchTvShowData();

    super.initState();
  }

  Widget buildImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.asset(
        imagePath,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fill,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: 140,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CarouselSlider(
                  items: [
                    buildImage("assets/images/slider.png"),
                    buildImage("assets/images/Cors1.png"),
                    buildImage("assets/images/Cors2.png"),
                    buildImage("assets/images/Cors3.png"),
                    buildImage("assets/images/d1.png"),
                    buildImage("assets/images/c2.png"),
                    buildImage("assets/images/c1.png"),
                  ],
                  options: CarouselOptions(
                      aspectRatio: 16 / 9,
                      // height: 160,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 2),
                      enlargeCenterPage: false,
                      viewportFraction: 1,
                      animateToClosest: true),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
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
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Shimmer.fromColors(
                      period: Duration(milliseconds: 2500),
                      baseColor: Colors.black,
                      highlightColor: Colors.white54,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.2,
                        color: Colors.white,
                      ));
                  ;
                } else if (snapshot.hasData) {
                  HomeMovies? homemovies = snapshot.data;

                  if (homemovies == null) {
                    return Center(
                      child: Text('Error: Received null data from the API.'),
                    );
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width,
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
                                        builder: (context) => AboutMovieDetails(
                                              MoviePoster:
                                                  homemovielist?.backdropPath ??
                                                      "",
                                              MovieName:
                                                  homemovielist?.title ?? "",
                                              MovieId: homemovielist!.iId,
                                              MovieGenres:
                                                  homemovielist?.genres ?? [],
                                              MovieOverview:
                                                  homemovielist?.overview ?? "",
                                              MovieReleasedate:
                                                  homemovielist?.releaseDate ??
                                                      "",
                                            )));
                              },
                              child: Builder(builder: (context) {
                                return Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
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
                                                      0.3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  color: Colors.white54,
                                                ));
                                          }
                                        },
                                        homemovielist?.posterPath ?? "",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    // Container(
                                    //   width: MediaQuery.of(context).size.width *
                                    //       0.2,
                                    //   child: Text(
                                    //     homemovielist?.title ?? "",
                                    //     softWrap: true,
                                    //     overflow: TextOverflow.ellipsis,
                                    //     style: TextStyle(color: Colors.white),
                                    //   ),
                                    // )
                                  ],
                                );
                              }),
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top Hollywood Movie',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SellAllHollywoodMovie(),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: FutureBuilder(
                future: trendingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    List<Movie> movies = snapshot.data as List<Movie>;

                    return Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width,
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
                              children: [
                                Builder(builder: (context) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      // width: 128,
                                      height: 140,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
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
                                                      0.3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  color: Colors.white54,
                                                ));
                                          }
                                        },
                                        '${Constants.imagePath}${movie.posterPath ?? ''}',
                                        // fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // Flexible(
                                //   child: Container(
                                //     width: 128.61,
                                //     child: Text(
                                //       "${movie.title}",
                                //       textAlign: TextAlign.center,
                                //       overflow: TextOverflow.ellipsis,
                                //       softWrap: true,
                                //       style: TextStyle(
                                //         color: Color(0xFFF09047),
                                //         fontSize: 15,
                                //         fontFamily: 'Inter',
                                //         fontWeight: FontWeight.w600,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
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
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top Bollywood Movies',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
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
                  List<HindiMovie> hindimovie =
                      snapshot.data as List<HindiMovie>;

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: 140,
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
                                      // width: 128.61,
                                      height: 140,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 5,
                                      ),
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
                                                      0.3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  color: Colors.white54,
                                                ));
                                          }
                                        },
                                        '${Constants.imagePath}${hindiMovie.posterPath ?? ''}',
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  );
                                }),
                                // Flexible(
                                //   child: Container(
                                //     width: 128.61,
                                //     child: Text(
                                //       "${hindiMovie.title}",
                                //       softWrap: true,
                                //       style: TextStyle(
                                //         color: Color(0xFFF09047),
                                //         fontSize: 15,
                                //         fontFamily: 'Inter',
                                //         fontWeight: FontWeight.w600,
                                //       ),
                                //     ),
                                //   ),
                                // ),
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
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top Movies',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
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
                      height: 140,
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
                                      // width: 128.61,
                                      height: 140,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
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
                                                      0.3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  color: Colors.white54,
                                                ));
                                          }
                                        },
                                        '${Constants.imagePath}${discovermovies.posterPath ?? ''}',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                }),
                                // Container(
                                //   width: 128.61,
                                //   child: Text(
                                //     "${discovermovies.title}",
                                //     overflow: TextOverflow.ellipsis,
                                //     style: TextStyle(
                                //       color: Color(0xFFF09047),
                                //       fontSize: 15,
                                //       fontFamily: 'Inter',
                                //       fontWeight: FontWeight.w600,
                                //     ),
                                //   ),
                                // ),
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
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top Rated Shows',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
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
                      height: 150,
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
                                    builder: (context) => LiveTvShowDetail(
                                      liveTVShowDetail: tvShow,
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
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
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
                                                      0.3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  color: Colors.white54,
                                                ));
                                          }
                                        },
                                        '${Constants.imagePath}${tvShow.posterPath ?? ''}',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                }),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                // Flexible(
                                //   child: Container(
                                //     width: 128.61,
                                //     child: Text(
                                //       "${tvShow.name}",
                                //       overflow: TextOverflow.ellipsis,
                                //       softWrap: true,
                                //       style: TextStyle(
                                //         color: Color(0xFFF09047),
                                //         fontSize: 15,
                                //         fontFamily: 'Inter',
                                //         fontWeight: FontWeight.w600,
                                //       ),
                                //     ),
                                //   ),
                                // ),
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
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Anime Shows',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SeeAllKidsAnime()));
                      },
                      child: Text(
                        'See all',
                        style: TextStyle(
                          color: Color(0xFFF09047),
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            FutureBuilder<List<KidsAnimeModel>>(
              future: kidsAnime,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ShimmerLoadListView();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var animeData = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      KidsAnimeDetails(kidsModel: animeData),
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
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
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
                                                      0.3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  color: Colors.white54,
                                                ));
                                          }
                                        },
                                        '${animeData.image}',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  );
                                }),
                                // SizedBox(height: 8),
                                // Container(
                                //   margin: EdgeInsets.symmetric(horizontal: 5),
                                //   width:
                                //       MediaQuery.of(context).size.width * 0.4,
                                //   child: Text(
                                //     "${animeData.title}",
                                //     overflow: TextOverflow.ellipsis,
                                //     style: TextStyle(
                                //       color: Color(0xFFF09047),
                                //       fontSize: 15,
                                //       fontFamily: 'Inter',
                                //       fontWeight: FontWeight.w600,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bollywood Music',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SeeAllBollywoodMusic()));
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
            FutureBuilder<FeaturedPlaylists?>(
              future: featuredPlaylists,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return ShimmerLoadListView();
                } else if (snapshot.hasData) {
                  // Check if the data is not null before casting
                  FeaturedPlaylists? featuredPlaylist = snapshot.data;

                  if (featuredPlaylist == null) {
                    return Center(
                      child: Text('Error: Received null data from the API.'),
                    );
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          height: 160,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                featuredPlaylist.playlists?.items?.length ?? 0,
                            itemBuilder: (context, index) {
                              Items? item =
                                  featuredPlaylist.playlists?.items?[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FeaturedPlaylistTracks(
                                                  playlistId: item?.id ?? '',
                                                  playlistImage:
                                                      item?.images?[0].url ??
                                                          "",
                                                  playlistName:
                                                      item?.name ?? '',
                                                  playlistDescription:
                                                      item?.description ?? '',
                                                  playlistType:
                                                      item?.type ?? '',
                                                )));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Builder(builder: (context) {
                                        return Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 150,
                                          child: Image.network(
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent?
                                                        loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              } else {
                                                return Shimmer.fromColors(
                                                    baseColor: Colors.black,
                                                    highlightColor:
                                                        Colors.white12,
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.2,
                                                      color: Colors.white54,
                                                    ));
                                              }
                                            },
                                            '${item?.images?[0].url ?? ""}',
                                            fit: BoxFit.fill,
                                          ),
                                        );
                                      }),
                                      SizedBox(height: 8),
                                      // Container(
                                      //   width: MediaQuery.of(context).size.width *
                                      //       0.4,
                                      //   child: Text(
                                      //     "${item?.name}",
                                      //     // maxLines: 2,
                                      //     overflow: TextOverflow.ellipsis,
                                      //     textAlign: TextAlign.center,
                                      //     style: TextStyle(
                                      //       color: Color(0xFFF09047),
                                      //       fontSize: 15,
                                      //       fontFamily: 'Inter',
                                      //       fontWeight: FontWeight.w600,
                                      //     ),
                                      //   ),
                                      // ),
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
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Original Hollywood Songs',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SeeAllHollywoodMusic()));
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
            FutureBuilder<List<HollywoodMusic>>(
              future: hollywoodMusicList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ShimmerLoadListView();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<HollywoodMusic> musicList = snapshot.data!;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: 90,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: musicList.length,
                        itemBuilder: (context, index) {
                          HollywoodMusic music = musicList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MusicDetailPage(
                                    musicList: musicList,
                                    initialIndex: index,
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
                                      width: 110,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      height: 90,
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
                                                      0.3,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  color: Colors.white54,
                                                ));
                                          }
                                        },
                                        music.image.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }),
                                // SizedBox(height: 8),
                                // Container(
                                //   width:
                                //       MediaQuery.of(context).size.width * 0.4,
                                //   child: Text(
                                //     "${music.title}",
                                //     overflow: TextOverflow.ellipsis,
                                //     textAlign: TextAlign.center,
                                //     style: TextStyle(
                                //       color: Color(0xFFF09047),
                                //       fontSize: 15,
                                //       fontFamily: 'Inter',
                                //       fontWeight: FontWeight.w600,
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
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
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      child: Image.network(
                                        '${Constants.imagePath}${tvShows[index].posterPath ?? ''}',
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
                  }
                },
              ),
            ),
            SizedBox(
              height: 65,
            ),
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            //     child: Container(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             'Top Rated Anime',
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 15,
            //               fontFamily: 'Inter',
            //               fontWeight: FontWeight.w600,
            //               height: 0,
            //             ),
            //           ),
            //           InkWell(
            //             onTap: () {
            //               Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) => SeAllAnime()));
            //             },
            //             child: Text(
            //               'See all',
            //               style: TextStyle(
            //                 color: Color(0xFFF09047),
            //                 fontSize: 15,
            //                 fontFamily: 'Inter',
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            //   FutureBuilder(
            //     future: animeTab,
            //     builder: (context, snapshot) {
            //       if (snapshot.hasError) {
            //         print(snapshot.error);
            //         return Center(
            //           child: Text(snapshot.error.toString()),
            //         );
            //       } else if (snapshot.connectionState ==
            //           ConnectionState.waiting) {
            //         return ShimmerLoadListView();
            //       } else if (snapshot.hasData) {
            //         List<Anime> animeList = snapshot.data as List<Anime>;

            //         return Padding(
            //           padding: EdgeInsets.symmetric(horizontal: 10),
            //           child: Container(
            //             height: 150,
            //             child: ListView.builder(
            //               scrollDirection: Axis.horizontal,
            //               itemCount: animeList.length,
            //               itemBuilder: (context, index) {
            //                 Anime anime = animeList[index];
            //                 return GestureDetector(
            //                   onTap: () {
            //                     Navigator.push(
            //                         context,
            //                         MaterialPageRoute(
            //                             builder: (context) => AnimeDetail(
            //                                   animedetail: anime,
            //                                 )));
            //                   },
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.center,
            //                     children: [
            //                       Builder(builder: (context) {
            //                         return ClipRRect(
            //                           borderRadius: BorderRadius.circular(10),
            //                           child: Container(
            //                             margin:
            //                                 EdgeInsets.symmetric(horizontal: 5),
            //                             height: 150,
            //                             // width: 130,
            //                             child: Image.network(
            //                               '${anime.image}',
            //                               fit: BoxFit.fitHeight,
            //                             ),
            //                           ),
            //                         );
            //                       }),
            //                       // SizedBox(height: 8),
            //                       // Container(
            //                       //   width: 125,
            //                       //   child: Text(
            //                       //     "${anime.title}",
            //                       //     overflow: TextOverflow.ellipsis,
            //                       //     style: TextStyle(
            //                       //       color: Color(0xFFF09047),
            //                       //       fontSize: 15,
            //                       //       fontFamily: 'Inter',
            //                       //       fontWeight: FontWeight.w600,
            //                       //     ),
            //                       //   ),
            //                       // ),
            //                     ],
            //                   ),
            //                 );
            //               },
            //             ),
            //           ),
            //         );
            //       } else {
            //         return ShimmerLoadListView();
            //       }
            //     },
            //   ),
            //   SizedBox(
            //     height: 5,
            //   ),
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            //     child: Container(
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             'Latest & Trending',
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 15,
            //               fontFamily: 'Inter',
            //               fontWeight: FontWeight.w600,
            //               height: 0,
            //             ),
            //           ),
            //           Text(
            //             'See all',
            //             style: TextStyle(
            //               color: Color(0xFFF09047),
            //               fontSize: 15,
            //               fontFamily: 'Inter',
            //               fontWeight: FontWeight.w600,
            //               height: 0,
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 15),
            //     child: Container(
            //       height: 81,
            //       child: ListView.builder(
            //         scrollDirection: Axis.horizontal,
            //         itemCount: imagePaths14.length,
            //         itemBuilder: (_, index) {
            //           return Container(
            //             width: 128.61,
            //             height: 80,
            //             margin: EdgeInsets.symmetric(horizontal: 5),
            //             decoration: BoxDecoration(
            //               image: DecorationImage(
            //                 image: AssetImage(imagePaths14[index]),
            //               ),
            //             ),
            //           );
            //         },
            //       ),
            //     ),
            //   ),
            // ],
          ],
        ),
      ),
    );
  }
}
