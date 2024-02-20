import 'package:flutter/material.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/hollywoodMovieDetail.dart';
import 'package:ott/screens/widgets/constants.dart';
import 'package:ott/model/api.dart';
import 'package:ott/model/movie.dart';
import 'package:ott/screens/widgets/shimmerLoadingGridView.dart';

class SellAllHollywoodMovie extends StatefulWidget {
  const SellAllHollywoodMovie({super.key});

  @override
  State<SellAllHollywoodMovie> createState() => _SellAllHollywoodMovieState();
}

class _SellAllHollywoodMovieState extends State<SellAllHollywoodMovie> {
  late Future<List<Movie>> trendingMovies;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trendingMovies = Api().getTrendingMovies();
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
        future: trendingMovies,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            List<Movie> movies = snapshot.data as List<Movie>;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 0.7, // Adjust this value as needed
                ),
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
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Image.network(
                                '${Constants.imagePath}${movie.posterPath ?? ''}',
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: 8),
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.4, // Adjust the width as needed
                          child: Text(
                            "${movie.title}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFF09047),
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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
