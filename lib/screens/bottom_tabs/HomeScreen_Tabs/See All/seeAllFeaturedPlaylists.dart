import 'package:flutter/material.dart';
import 'package:ott/model/featuredPlaylists.dart';
import 'package:ott/model/spotify-services.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/featuredPlaylistDetails.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/music_tab.dart';

class SeeAllFeaturedPlaylists extends StatefulWidget {
  const SeeAllFeaturedPlaylists({super.key});

  @override
  State<SeeAllFeaturedPlaylists> createState() =>
      _SeeAllFeaturedPlaylistsState();
}

class _SeeAllFeaturedPlaylistsState extends State<SeeAllFeaturedPlaylists> {
  late Future<FeaturedPlaylists?> featuredPlaylists;

  @override
  void initState() {
    super.initState();
    featuredPlaylists = SpotifyService().fetchFeaturedPlaylists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFFF09047)),
        backgroundColor: Colors.black,
        title: Text(
          "Playlists",
          style:
              TextStyle(color: Color(0xFFF09047), fontWeight: FontWeight.w500),
        ),
      ),
      body: FutureBuilder<FeaturedPlaylists?>(
        future: featuredPlaylists,
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
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: featuredPlaylist.playlists?.items?.length ?? 0,
                itemBuilder: (context, index) {
                  Items? item = featuredPlaylist.playlists?.items?[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeaturedPlaylistTracks(
                                      playlistId: item?.id ?? '',
                                      playlistImage: item?.images?[0].url ?? "",
                                      playlistName: item?.name ?? '',
                                      playlistDescription:
                                          item?.description ?? '',
                                      playlistType: item?.type ?? '',
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
                                  '${item?.images?[0].url ?? ""}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: 8),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                              "${item?.name}",
                              // maxLines: 2,
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
                          // Container(
                          //   width: MediaQuery.of(context).size.width * 0.4,
                          //   child: Text(
                          //     "${item?.uri}",
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
