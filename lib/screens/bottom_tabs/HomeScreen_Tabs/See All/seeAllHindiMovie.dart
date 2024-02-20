import 'package:flutter/material.dart';
import 'package:ott/model/hindiMovie.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/bollywoodMovieDetails.dart';
import 'package:ott/screens/widgets/constants.dart';

class SeeAllBollywoodMovie extends StatefulWidget {
  final Future<List<HindiMovie>> hindiMovie;

  SeeAllBollywoodMovie({required this.hindiMovie});

  @override
  _SeeAllBollywoodMovieState createState() => _SeeAllBollywoodMovieState();
}

class _SeeAllBollywoodMovieState extends State<SeeAllBollywoodMovie> {
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
      body: Container(
        child: FutureBuilder(
          future: widget.hindiMovie,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              List<HindiMovie> hindimovie = snapshot.data as List<HindiMovie>;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 0.7, // Adjust this value as needed
                  ),
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
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.28,
                                child: Image.network(
                                  '${Constants.imagePath}${hindiMovie.posterPath ?? ''}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: 8),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              "${hindiMovie.title}",
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
              return Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFF09047),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
