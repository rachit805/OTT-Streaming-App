import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ott/model/api.dart';
// import 'package:ott/model/artistsModel.dart';
import 'package:ott/model/reccomandedAlbumModel.dart';
import 'package:ott/model/spotify-services.dart';
import 'package:ott/model/tvshow.dart';
import 'package:http/http.dart' as http;

class Store_Screen_Tab extends StatefulWidget {
  const Store_Screen_Tab({Key? key}) : super(key: key);

  @override
  State<Store_Screen_Tab> createState() => _Store_Screen_TabState();
}

class _Store_Screen_TabState extends State<Store_Screen_Tab> {
  // late Future<FeaturedPlaylists?> featuredPlaylists;
  // late Future<ArtistsData?> artistsData;
  late Future<ReccomandedAlbum?> reccomandedAlbum;

  @override
  void initState() {
    super.initState();
    reccomandedAlbum = fetchReccomandation();

    // artistsData = SpotifyService().fetchArtistsData();
    // featuredPlaylists = SpotifyService().fetchFeaturedPlaylists();
  }

  Future<ReccomandedAlbum?> fetchReccomandation() async {
    String apiUrl =
        'https://api.spotify.com/v1/recommendations?seed_artists=4NHQUGzhtTLFvgF5SZesLK&seed_genres=classical%2Ccountry&seed_tracks=5ZLkihi6DVsHwDL3B8ym1t';

    try {
      final authenticationToken = await SpotifyService.getAuthenticationToken();

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $authenticationToken'},
      );

      if (response.statusCode == 200) {
        final jsonResult = json.decode(response.body);
        print("Reccomandation data decoded");
        print(response.body);
        ReccomandedAlbum reccomanded = ReccomandedAlbum.fromJson(jsonResult);
        if (reccomanded.tracks != null) {
          for (Tracks track in reccomanded.tracks!) {
            print('Track ID: ${track.id}');
            print('Track Name: ${track.name}');
            print(
                'Artists: ${track.artists?.map((artist) => artist.name).join(', ')}');
            print('image:${track.album?.images?.map((image) => image.url)}');
            print('Album Name: ${track.album?.name}');
            print('Duration: ${track.durationMs} ms');
            print('Popularity: ${track.popularity}');
            print('Preview URL: ${track.previewUrl}');
            print('URI: ${track.uri}');
            print('---');
          }
        }
        return ReccomandedAlbum.fromJson(jsonResult);
      } else {
        print('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Artists',
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
          // FutureBuilder<ArtistsData?>(
          //   future: artistsData, // Assuming you have a function to fetch data
          //   builder: (context, snapshot) {
          //     if (snapshot.hasError) {
          //       print(snapshot.error);
          //       return Center(
          //         child: Text(snapshot.error.toString()),
          //       );
          //     } else if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Center(
          //         child: CircularProgressIndicator(
          //           color: Color(0xFFF09047),
          //         ),
          //       );
          //     } else if (snapshot.hasData) {
          //       ArtistsData? artistsData = snapshot.data;

          //       if (artistsData == null) {
          //         return Center(
          //           child: Text('Error: Received null data from the API.'),
          //         );
          //       }

          //       return Padding(
          //         padding: EdgeInsets.symmetric(horizontal: 20),
          //         child: Column(
          //           children: [
          //             Container(
          //               height: 160,
          //               child: ListView.builder(
          //                 scrollDirection: Axis.horizontal,
          //                 itemCount: artistsData.artists?.length ?? 0,
          //                 itemBuilder: (context, index) {
          //                   Artists artists = artistsData.artists![index];
          //                   return Padding(
          //                     padding: const EdgeInsets.only(right: 10),
          //                     child: Column(
          //                       crossAxisAlignment: CrossAxisAlignment.center,
          //                       children: [
          //                         Container(
          //                           decoration: BoxDecoration(
          //                             shape: BoxShape.circle,
          //                           ),
          //                           height: 100,
          //                           width: 100,
          //                           child: ClipOval(
          //                             child: Image.network(
          //                               '${artists.images?[0].url ?? ""}',
          //                               fit: BoxFit.cover,
          //                             ),
          //                           ),
          //                         ),
          //                         SizedBox(height: 8),
          //                         Container(
          //                           width:
          //                               MediaQuery.of(context).size.width * 0.4,
          //                           child: Text(
          //                             "${artists.name}",
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
          //                       ],
          //                     ),
          //                   );
          //                 },
          //               ),
          //             ),
          //           ],
          //         ),
          //       );
          //     } else {
          //       return Center(
          //         child: CircularProgressIndicator(
          //           color: Color(0xFFF09047),
          //         ),
          //       );
          //     }
          //   },
          // ),
          FutureBuilder<ReccomandedAlbum?>(
            future: reccomandedAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
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
                ReccomandedAlbum? reccomandedAlbum = snapshot.data;

                if (reccomandedAlbum == null) {
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
                          itemCount: reccomandedAlbum.tracks?.length ?? 0,
                          itemBuilder: (context, index) {
                            Tracks? track = reccomandedAlbum.tracks?[index];
                            Images? image = track?.album?.images?[0];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Builder(builder: (context) {
                                      return Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height: 150,
                                        child: Image.network(
                                          image?.url ?? "",
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    }),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
        ],
      ),
    );
  }
}
