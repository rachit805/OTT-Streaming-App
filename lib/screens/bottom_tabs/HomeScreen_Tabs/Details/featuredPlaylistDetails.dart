import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ott/model/PlaylistDetails.dart';
import 'package:ott/model/spotify-services.dart';
import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/playMusicScreen.dart';
import 'package:ott/screens/widgets/shimmerLoadList.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:convert';

import 'package:spotify_sdk/spotify_sdk.dart';

class FeaturedPlaylistTracks extends StatefulWidget {
  const FeaturedPlaylistTracks({
    Key? key,
    required this.playlistId,
    required this.playlistImage,
    required this.playlistName,
    required this.playlistDescription,
    required this.playlistType,
  }) : super(key: key);

  final String playlistId;
  final String playlistImage;
  final String playlistName;
  final String playlistDescription;
  final String playlistType;

  @override
  State<FeaturedPlaylistTracks> createState() => _FeaturedPlaylistTracksState();
}

class _FeaturedPlaylistTracksState extends State<FeaturedPlaylistTracks> {
  late Future<PlaylistDetails?> playlistDetails;
  late List<bool> isTrackPlaying;

  @override
  void initState() {
    super.initState();
    playlistDetails = fetchPlaylistDetails();
  }

  Future<PlaylistDetails?> fetchPlaylistDetails() async {
    String apiUrl = 'https://api.spotify.com/v1/playlists/${widget.playlistId}';

    try {
      final authenticationToken = await SpotifyService.getAuthenticationToken();

      final response = await http.get(Uri.parse(apiUrl), headers: {
        'Authorization': 'Bearer $authenticationToken',
      });

      if (response.statusCode == 200) {
        final jsonResult = json.decode(response.body);
        print("Featured Playlist details decoded");
        print(response.body);

        PlaylistDetails playlistDetails = PlaylistDetails.fromJson(jsonResult);

        // Initialize isTrackPlaying list with false for each track
        isTrackPlaying = List.generate(
            playlistDetails?.tracks?.items?.length ?? 0, (index) => false);

        return playlistDetails;
      } else {
        print('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  Future<void> togglePlayPause(int trackIndex) async {
    try {
      PlaylistDetails? details = await playlistDetails;

      if (details != null) {
        for (int i = 0; i < isTrackPlaying.length; i++) {
          if (isTrackPlaying[i] && i != trackIndex) {
            await SpotifySdk.pause();
            setState(() {
              isTrackPlaying[i] = false;
            });
            // Remove the break statement
          }
        }

        // Play the selected track
        if (!isTrackPlaying[trackIndex]) {
          String trackUri =
              details.tracks!.items![trackIndex].track!.uri.toString();
          await SpotifySdk.play(spotifyUri: trackUri);
        }

        // Update the play/pause state for the selected track
        setState(() {
          isTrackPlaying[trackIndex] = !isTrackPlaying[trackIndex];
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  String calculateRemainingTime(int totalDuration, int currentTrackPosition) {
    int remainingTimeInSeconds =
        ((totalDuration - currentTrackPosition) / 1000).round();
    int minutes = remainingTimeInSeconds ~/ 60;
    int seconds = remainingTimeInSeconds % 60;

    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5),
                      BlendMode.darken,
                    ),
                    child: Image.network(
                      widget.playlistImage,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          // Color(0xFF000000).withOpacity(
                          //     0.5), // Black color with high opacity at the top
                          Colors.transparent, // Transparent in the middle
                          Color(0xFF000000).withOpacity(
                              0.9), // Black color with high opacity at the bottom
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              )),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.22,
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Playlist",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            widget.playlistName,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 38,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.playlistDescription,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.09,
                          child: Text(
                            "#",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Text(
                            "Name",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: Text(
                            "Album",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.08,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Icon(
                            Icons.watch_later,
                            color: Colors.white70,
                            size: 18,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.06,
                        ),
                        Container(
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                    thickness: 0,
                    color: Colors.white38,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: FutureBuilder<PlaylistDetails?>(
                  future: playlistDetails,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ShimmerLoadVerList();
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData ||
                        snapshot.data?.tracks == null) {
                      return Center(
                        child: Text(
                          'No tracks available.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.tracks!.items!.length,
                        itemBuilder: (context, index) {
                          var item = snapshot.data!.tracks!.items![index].track;
                          var image = item?.album?.images?.isNotEmpty == true
                              ? item!.album!.images![0].url
                              : null;
                          var artist = item?.artists?.isNotEmpty == true
                              ? item!.artists![0]
                              : null;

                          return GestureDetector(
                            onTap: () {
                              print(item.uri);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlayMusicScreen(
                                    trackName: item.name.toString(),
                                    artistName: artist!.name.toString(),
                                    imageUrl: image,
                                    trackUrl: '',
                                    trackuri: item.uri.toString(),
                                    artisturi: artist.uri.toString(),
                                  ),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.12),
                                    border: Border.all(
                                      width: 0.5,
                                      color: isTrackPlaying[index]
                                          ? Color(0xFFF09047)
                                          : Colors.white.withOpacity(0.12),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.09,
                                        child: Text(
                                          "${index + 1}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: isTrackPlaying[index]
                                                ? Color(0xFFF09047)
                                                : Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          child: Image.network(
                                            image!,
                                            width: 28,
                                            height: 60,
                                          ),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Text(
                                          item!.name ?? 'N/A',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: isTrackPlaying[index]
                                                ? Color(0xFFF09047)
                                                : Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15,
                                        child: Text(
                                          item.album?.name ?? 'N/A',
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: isTrackPlaying[index]
                                                ? Color(0xFFF09047)
                                                : Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.08,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        child: Text(
                                          isTrackPlaying[index]
                                              ? calculateRemainingTime(
                                                  item.durationMs!,
                                                  0,
                                                )
                                              : "${(item.durationMs! ~/ 1000 ~/ 60).toString().padLeft(2, '0')}:${(item.durationMs! ~/ 1000 % 60).toString().padLeft(2, '0')}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: isTrackPlaying[index]
                                                ? Color(0xFFF09047)
                                                : Colors.white,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.09,
                                        child: IconButton(
                                          icon: isTrackPlaying[index]
                                              ? const Icon(Icons.pause)
                                              : const Icon(Icons.play_arrow),
                                          iconSize: 28,
                                          color: isTrackPlaying[index]
                                              ? Color(
                                                  0xFFF09047) // Change color when playing
                                              : Color(0xFFF09047),
                                          onPressed: () {
                                            togglePlayPause(index);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerLoadVerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Shimmer.fromColors(
              baseColor: Colors.black!,
              highlightColor: Colors.white!,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        // Container(
                        //   width: MediaQuery.of(context).size.width * 0.2,
                        //   height: 16,
                        //   color: Colors.white,
                        // ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

























// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:ott/model/PlaylistDetails.dart';
// import 'package:ott/model/spotify-services.dart';
// import 'package:ott/screens/bottom_tabs/HomeScreen_Tabs/Details/playMusicScreen.dart';
// import 'dart:convert';

// import 'package:spotify_sdk/spotify_sdk.dart';

// class FeaturedPlaylistTracks extends StatefulWidget {
//   const FeaturedPlaylistTracks({
//     Key? key,
//     required this.playlistId,
//     required this.playlistImage,
//     required this.playlistName,
//     required this.playlistDescription,
//     required this.playlistType,
//   }) : super(key: key);

//   final String playlistId;
//   final String playlistImage;
//   final String playlistName;
//   final String playlistDescription;
//   final String playlistType;

//   @override
//   State<FeaturedPlaylistTracks> createState() => _FeaturedPlaylistTracksState();
// }

// class _FeaturedPlaylistTracksState extends State<FeaturedPlaylistTracks> {
//   late Future<PlaylistDetails?> playlistDetails;
//   late List<bool> isTrackPlaying;

//   @override
//   void initState() {
//     super.initState();
//     playlistDetails = fetchPlaylistDetails();
//   }

//   Future<PlaylistDetails?> fetchPlaylistDetails() async {
//     String apiUrl = 'https://api.spotify.com/v1/playlists/${widget.playlistId}';

//     try {
//       final authenticationToken = await SpotifyService.getAuthenticationToken();

//       final response = await http.get(Uri.parse(apiUrl), headers: {
//         'Authorization': 'Bearer $authenticationToken',
//       });

//       if (response.statusCode == 200) {
//         final jsonResult = json.decode(response.body);
//         print("Featured Playlist details decoded");
//         print(response.body);

//         PlaylistDetails playlistDetails = PlaylistDetails.fromJson(jsonResult);

//         // Initialize isTrackPlaying list with false for each track
//         isTrackPlaying = List.generate(
//             playlistDetails?.tracks?.items?.length ?? 0, (index) => false);

//         return playlistDetails;
//       } else {
//         print('Failed to load data: ${response.statusCode}');
//         return null;
//       }
//     } catch (error) {
//       print('Error: $error');
//       return null;
//     }
//   }

//   Future<void> togglePlayPause(int trackIndex) async {
//     try {
//       PlaylistDetails? details = await playlistDetails;

//       if (details != null) {
//         if (isTrackPlaying[trackIndex]) {
//           await SpotifySdk.pause();
//         } else {
//           // Play the selected track
//           String trackUri =
//               details.tracks!.items![trackIndex].track!.uri.toString();
//           await SpotifySdk.play(spotifyUri: trackUri);
//         }

//         // Update the play/pause state for the current track
//         setState(() {
//           isTrackPlaying[trackIndex] = !isTrackPlaying[trackIndex];
//         });
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: CustomScrollView(
//         slivers: [
//           SliverAppBar(
//             automaticallyImplyLeading: true,
//             iconTheme: IconThemeData(color: Colors.white),
//             backgroundColor: Colors.black,
//             expandedHeight: 220,
//             pinned: true,
//             floating: false,
//             stretch: true,
//             stretchTriggerOffset: 100.0,
//             onStretchTrigger: () async {
//             },
//             flexibleSpace: FlexibleSpaceBar(
//               stretchModes: [
//                 StretchMode.zoomBackground,
//                 StretchMode.fadeTitle,
//               ],
//               background: Image.network(
//                 widget.playlistImage,
//                 width: MediaQuery.of(context).size.width,
//                 fit: BoxFit.cover,
//               ),
//               collapseMode: CollapseMode.parallax,
//               title: Container(
//                 child: Image.network(widget.playlistImage),
//                 height: 80, // Adjust the size of the centered image as needed
//                 width: 80,
//               ),
//             ),
//           ),
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (context, index) {
//                 return FutureBuilder<PlaylistDetails?>(
//                   future: playlistDetails,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Container(
//                         height: 30,
//                         width: 30,
//                         child: Center(
//                           child: CircularProgressIndicator(
//                             color: Color(0xFFF09047),
//                           ),
//                         ),
//                       );
//                     } else if (snapshot.hasError) {
//                       return Center(child: Text('Error: ${snapshot.error}'));
//                     } else if (!snapshot.hasData ||
//                         snapshot.data?.tracks == null) {
//                       return Center(
//                         child: Text(
//                           'No tracks available.',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       );
//                     } else {
//                       var item = snapshot.data!.tracks!.items![index].track;
//                       var image = item?.album?.images?.isNotEmpty == true
//                           ? item!.album!.images![0].url
//                           : null;

//                       return GestureDetector(
//                         onTap: () {
//                           print(item?.uri);
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => PlayMusicScreen(
//                                 trackName: item?.name.toString() ?? '',
//                                 artistName: '',
//                                 imageUrl: image,
//                                 trackUrl: '',
//                                 trackuri: item?.uri.toString() ?? '',
//                               ),
//                             ),
//                           );
//                         },
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   border: Border(),
//                                   color: Colors.white12,
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       width: MediaQuery.of(context).size.width *
//                                           0.09,
//                                       child: Text(
//                                         "${index + 1}",
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           color: Color(0xFFF09047),
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w700,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(40),
//                                         child: Image.network(
//                                           image!,
//                                           width: 28,
//                                           height: 60,
//                                         ),
//                                       ),
//                                       width: MediaQuery.of(context).size.width *
//                                           0.1,
//                                     ),
//                                     SizedBox(
//                                       width: 4,
//                                     ),
//                                     Container(
//                                       width: MediaQuery.of(context).size.width *
//                                           0.2,
//                                       child: Text(
//                                         item!.name ?? 'N/A',
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 15,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width *
//                                           0.05,
//                                     ),
//                                     Container(
//                                       width: MediaQuery.of(context).size.width *
//                                           0.15,
//                                       child: Text(
//                                         item.album?.name ?? 'N/A',
//                                         textAlign: TextAlign.center,
//                                         maxLines: 2,
//                                         softWrap: true,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width *
//                                           0.08,
//                                     ),
//                                     Container(
//                                       width: MediaQuery.of(context).size.width *
//                                           0.1,
//                                       child: Text(
//                                         "${(item.durationMs! ~/ 1000 ~/ 60).toString().padLeft(2, '0')}:${(item.durationMs! ~/ 1000 % 60).toString().padLeft(2, '0')}",
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width *
//                                           0.03,
//                                     ),
//                                     Container(
//                                       width: MediaQuery.of(context).size.width *
//                                           0.09,
//                                       child: IconButton(
//                                         icon: isTrackPlaying[index]
//                                             ? const Icon(Icons.pause)
//                                             : const Icon(Icons.play_arrow),
//                                         iconSize: 28,
//                                         color: Color(0xFFF09047),
//                                         onPressed: () {
//                                           togglePlayPause(index);
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//                   },
//                 );
//               },
//               childCount:
//                   50, // Set this to 1, or you can use your custom logic here
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
