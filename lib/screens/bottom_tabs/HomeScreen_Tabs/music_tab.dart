import 'package:flutter/material.dart';
import 'package:ott/model/artistsModel.dart';
import 'package:ott/model/bollywoodmusic.dart';
import 'package:ott/model/featuredPlaylists.dart';
import 'package:ott/model/music.dart';
import 'package:ott/model/api.dart';
import 'package:ott/model/spotify-services.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/featuredPlaylistDetails.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/See%20All/seeAllBollywoodMusic.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/See%20All/seeAllFeaturedPlaylists.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/See%20All/seeAllHollywoodMusic.dart';
import 'package:ott/screens/widgets/shimmerLoadList.dart';

class MusicTab extends StatefulWidget {
  const MusicTab({super.key});

  @override
  State<MusicTab> createState() => _MusicTabState();
}

class _MusicTabState extends State<MusicTab> {
  late Future<FeaturedPlaylists?> featuredPlaylists;
  late Future<ArtistsData?> artistsData;
  late Future<List<Music>> discoverMusic;

  // late Future<List<ChartEntry>> bollywoodMusic;

  @override
  void initState() {
    super.initState();
    featuredPlaylists = SpotifyService().fetchFeaturedPlaylists();

    discoverMusic = Future.value([]);
    fetchDiscoverMusic();
    artistsData = SpotifyService().fetchArtistsData();

    // bollywoodMusic = Api().getBollywoodMusicData();
  }

  Future<void> fetchDiscoverMusic() async {
    Api api = Api();
    String albumId = '112024';
    try {
      Music? music = await api.getMusicDetails(albumId);

      if (music != null) {
        // Process the retrieved music data
        print('Music Title: ${music.strAlbum}');
        // Set the state with the fetched data
        setState(() {
          discoverMusic = Future.value([music]);
        });
      } else {
        print('Failed to fetch music details.');
      }
    } catch (error) {
      print('Error in fetchMusicDetails: $error');
    }
  }

  // Future<List<ChartEntry>> fetchBollywoodMusic() async {
  //   Api api = Api();

  //   try {
  //     List<ChartEntry> fetchedMusic = await api.getBollywoodMusicData();

  //     if (fetchedMusic.isNotEmpty) {
  //       return fetchedMusic;
  //     } else {
  //       return [];
  //     }
  //   } catch (error) {
  //     print('Error in fetchBollywoodMusic: $error');
  //     return [];
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Playlists',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeeAllFeaturedPlaylists()));
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
              } else if (snapshot.connectionState == ConnectionState.waiting) {
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
                  child: Container(
                    height: 160,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
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
                                      builder: (context) =>
                                          FeaturedPlaylistTracks(
                                            playlistId: item?.id ?? '',
                                            playlistImage:
                                                item?.images?[0].url ?? "",
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
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: 150,
                                    child: Image.network(
                                      '${item?.images?[0].url ?? ""}',
                                      fit: BoxFit.cover,
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
                );
              } else {
                return ShimmerLoadListView();
              }
            },
          ),

          //Discover Music (Hollywood Music Horizontal ListView)
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Discover Album',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
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
          FutureBuilder(
            future: discoverMusic,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return ShimmerLoadListView();
              } else if (snapshot.hasData) {
                // Check if the data is not null before casting
                List<Music>? music = snapshot.data;

                if (music == null) {
                  return Center(
                    child: Text('Error: Received null data from the API.'),
                  );
                }

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SeeAllHollywoodMusic()));
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 190,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: music.length,
                            itemBuilder: (context, index) {
                              Music musictab = music[index];
                              return GestureDetector(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Builder(builder: (context) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: 150,
                                          child: Image.network(
                                            '${musictab.strAlbumThumb}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }),
                                    SizedBox(height: 8),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Text(
                                        "${musictab.strArtist}",
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
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return ShimmerLoadListView();
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Artists',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    // onTap: () {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => SeeAllHollywoodMusic()));
                    // },
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
          FutureBuilder<ArtistsData?>(
            future: artistsData, // Assuming you have a function to fetch data
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return ShimmerLoadListView();
              } else if (snapshot.hasData) {
                ArtistsData? artistsData = snapshot.data;

                if (artistsData == null) {
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
                          itemCount: artistsData.artists?.length ?? 0,
                          itemBuilder: (context, index) {
                            Artists artists = artistsData.artists![index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    height: 100,
                                    width: 100,
                                    child: ClipOval(
                                      child: Image.network(
                                        '${artists.images?[0].url ?? ""}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      "${artists.name}",
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
                      ),
                    ],
                  ),
                );
              } else {
                return ShimmerLoadListView();
              }
            },
          ),

          // Padding(
          //   padding: const EdgeInsets.all(15),
          //   child: Container(
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           'Bollywood Music',
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 15,
          //             fontFamily: 'Inter',
          //             fontWeight: FontWeight.w600,
          //           ),
          //         ),
          //         InkWell(
          //           onTap: () {
          //             Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                     builder: (context) => SeeAllBollywoodMusic()));
          //           },
          //           child: Text(
          //             'See all',
          //             style: TextStyle(
          //               color: Color(0xFFF09047),
          //               fontSize: 15,
          //               fontFamily: 'Inter',
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          // FutureBuilder(
          //   future: bollywoodMusic,
          //   builder: (context, snapshot) {
          //     if (snapshot.hasError) {
          //       return Center(
          //         child: Text('Error loading data.'),
          //       );
          //     } else if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Center(
          //         child: CircularProgressIndicator(
          //           color: Color(0xFFF09047),
          //         ),
          //       );
          //     } else if (snapshot.hasData) {
          //       List<ChartEntry>? bollywoodmusic = snapshot.data;

          //       if (bollywoodmusic == null || bollywoodmusic.isEmpty) {
          //         return Center(
          //           child: Text('No Bollywood music data.'),
          //         );
          //       }

          //       return Padding(
          //         padding: EdgeInsets.symmetric(horizontal: 20),
          //         child: Container(
          //           height: 180,
          //           child: ListView.builder(
          //             scrollDirection: Axis.horizontal,
          //             itemCount: bollywoodmusic.length,
          //             itemBuilder: (context, index) {
          //               ChartEntry bollywoodmusictab = bollywoodmusic[index];

          //               return Padding(
          //                 padding: const EdgeInsets.only(right: 10),
          //                 child: GestureDetector(
          //                   child: Column(
          //                     crossAxisAlignment: CrossAxisAlignment.center,
          //                     children: [
          //                       Builder(builder: (context) {
          //                         return ClipRRect(
          //                           borderRadius: BorderRadius.circular(10),
          //                           child: Container(
          //                             width: MediaQuery.of(context).size.width *
          //                                 0.4,
          //                             height: 150,
          //                             child: Image.network(
          //                               bollywoodmusictab
          //                                   .trackMetadata.displayImageUri!,
          //                               fit: BoxFit.cover,
          //                             ),
          //                           ),
          //                         );
          //                       }),
          //                       SizedBox(height: 8),
          //                       Flexible(
          //                         child: Container(
          //                           width:
          //                               MediaQuery.of(context).size.width * 0.4,
          //                           child: Text(
          //                             "${bollywoodmusictab.trackMetadata.trackName}",
          //                             maxLines: 2,
          //                             overflow: TextOverflow.ellipsis,
          //                             textAlign: TextAlign.center,
          //                             style: TextStyle(
          //                               color: Color(0xFFF09047),
          //                               fontSize: 15,
          //                               fontFamily: 'Inter',
          //                               fontWeight: FontWeight.w600,
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               );
          //             },
          //           ),
          //         ),
          //       );
          //     } else {
          //       return Container();
          //     }
          //   },
          // ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
