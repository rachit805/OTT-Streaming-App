import 'package:flutter/material.dart';
import 'package:ott/model/api.dart';
import 'package:ott/model/bollywoodmusic.dart';
import 'package:ott/model/featuredPlaylists.dart';
import 'package:ott/model/spotify-services.dart';
import 'package:ott/screens/widgets/shimmerLoadList.dart';
import 'package:ott/screens/widgets/shimmerLoadingGridView.dart';

class SeeAllBollywoodMusic extends StatefulWidget {
  const SeeAllBollywoodMusic({super.key});

  @override
  State<SeeAllBollywoodMusic> createState() => _SeeAllBollywoodMusicState();
}

class _SeeAllBollywoodMusicState extends State<SeeAllBollywoodMusic> {
  late Future<FeaturedPlaylists?> featuredPlaylists;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    featuredPlaylists = SpotifyService().fetchFeaturedPlaylists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Colors.black,
      body: FutureBuilder<FeaturedPlaylists?>(
        future: featuredPlaylists,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return ShimmerLoadGridView();
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
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: featuredPlaylist.playlists?.items?.length ?? 0,
                itemBuilder: (context, index) {
                  Items? item = featuredPlaylist.playlists?.items?[index];

                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Builder(builder: (context) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 170,
                                child: Image.network(
                                  '${item?.images?[0].url ?? ""}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: 8),
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                "${item?.name.toString()}",
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
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
