import 'package:flutter/material.dart';
import 'package:ott/model/api.dart';
import 'package:ott/model/kidsAnimeModel.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/kidsAnimeDetails.dart';
import 'package:ott/screens/widgets/shimmerLoadingGridView.dart';

class SeeAllKidsAnime extends StatefulWidget {
  const SeeAllKidsAnime({super.key});

  @override
  State<SeeAllKidsAnime> createState() => _SeeAllKidsAnimeState();
}

class _SeeAllKidsAnimeState extends State<SeeAllKidsAnime> {
  late Future<List<KidsAnimeModel>> kidsAnime;
  @override
  void initState() {
    super.initState();
    kidsAnime = Api().fetchKidsAnimeData();
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
        child: FutureBuilder<List<KidsAnimeModel>>(
          future: kidsAnime,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ShimmerLoadGridView();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.7,
                  ),
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
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: Image.network(
                                  '${animeData.image}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: 8),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              "${animeData.title}",
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
            }
          },
        ),
      ),
    );
  }
}
