import 'package:flutter/material.dart';
import 'package:ott/model/api.dart';
import 'package:ott/model/hindiTvshowModel.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/TvShowDetails.dart';
import 'package:ott/screens/widgets/constants.dart';
import 'package:ott/screens/widgets/shimmerLoadingGridView.dart';
import 'package:shimmer/shimmer.dart';

class SeeAllWeekTopShow extends StatefulWidget {
  const SeeAllWeekTopShow({super.key});

  @override
  State<SeeAllWeekTopShow> createState() => _SeeAllWeekTopShowState();
}

class _SeeAllWeekTopShowState extends State<SeeAllWeekTopShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFF09047)),
        backgroundColor: Colors.black,
        title: Text(
          "Weekly Top Show",
          style: TextStyle(
            color: Color(0xFFF09047),
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<HindiTvShow>>(
        future: Api().fetchHindiTvShows(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerLoadGridView();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<HindiTvShow> tvShows = snapshot.data!;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: tvShows.length,
                itemBuilder: (context, index) {
                  HindiTvShow Show = tvShows[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TvShowDetails(
                            Id: Show.id.toString(),
                            Name: Show.name,
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
                                '${Constants.imagePath}${Show.posterPath ?? ''}',
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
    );
  }
}
