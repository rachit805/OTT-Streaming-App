import 'package:flutter/material.dart';
import 'package:ott/model/anime.dart'; // Import your Anime model class
import 'package:ott/model/api.dart';
import 'package:ott/model/tvShows.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/animeDetail.dart';

class TvShowTab extends StatefulWidget {
  const TvShowTab({Key? key}) : super(key: key);

  @override
  State<TvShowTab> createState() => _TvShowTabState();
}

class _TvShowTabState extends State<TvShowTab> {
  late Future<List<TVShow>> tvShowTab;

  @override
  void initState() {
    super.initState();
    tvShowTab = Api().fetchTvShowData();
  }

  Future<List<TVShow>> fetchTvShows() async {
    Api api = Api();

    try {
      List<TVShow> tvShowList = await api.fetchTvShowData();
      return tvShowList;
    } catch (error) {
      print('Error in fetchAnimeDetails: $error');
      return []; // Return an empty list in case of an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: tvShowTab,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFFF09047),
              ),
            );
          } else if (snapshot.hasData) {
            List<TVShow> tvShowList = snapshot.data as List<TVShow>;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: tvShowList.length,
                itemBuilder: (context, index) {
                  TVShow tvshows = tvShowList[index];
                  return GestureDetector(
                    // onTap: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => AnimeDetail(
                    //                 animedetail: tvshows,
                    //               )));
                    // },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Builder(builder: (context) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 150,
                              child: Image.network(
                                '${tvshows.epguidesUrl}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: 8),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            tvshows.epguidesName,
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
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFFF09047),
              ),
            );
          }
        },
      ),
    );
  }
}
