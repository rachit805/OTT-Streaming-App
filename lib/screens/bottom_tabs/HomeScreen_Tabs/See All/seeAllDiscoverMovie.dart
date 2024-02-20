import 'package:flutter/material.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/discoverMovieDetail.dart';
import 'package:ott/screens/widgets/constants.dart';
import 'package:ott/model/api.dart';
import 'package:ott/model/discoverMovies.dart';
import 'package:ott/screens/widgets/shimmerLoadingGridView.dart';

class SeeAllDiscoverMovie extends StatefulWidget {
  const SeeAllDiscoverMovie({super.key});

  @override
  State<SeeAllDiscoverMovie> createState() => _SeeAllDiscoverMovieState();
}

class _SeeAllDiscoverMovieState extends State<SeeAllDiscoverMovie> {
  late Future<List<DiscoverMovies>> discoverMovies;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    discoverMovies = Api().getDiscoverMovies();
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
        future: discoverMovies,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            List<DiscoverMovies> movies = snapshot.data as List<DiscoverMovies>;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 0.7,
                ),
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
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: Image.network(
                                '${Constants.imagePath}${discovermovies.posterPath ?? ''}',
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
                            "${discovermovies.title}",
                            maxLines: 1,
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
