import 'package:flutter/material.dart';
import 'package:ott/model/anime.dart';
import 'package:ott/model/api.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/animeDetail.dart';

class SeAllAnime extends StatefulWidget {
  const SeAllAnime({super.key});

  @override
  State<SeAllAnime> createState() => _SeAllAnimeState();
}

class _SeAllAnimeState extends State<SeAllAnime> {
  late Future<List<Anime>> animeTab;
  @override
  void initState() {
    super.initState();
    animeTab = Api().fetchAnimeData();
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
        future: animeTab,
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
            List<Anime> animeList = snapshot.data as List<Anime>;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: animeList.length,
                itemBuilder: (context, index) {
                  Anime anime = animeList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnimeDetail(
                                    animedetail: anime,
                                  )));
                    },
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
                                '${anime.image}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: 8),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "${anime.title}",
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
