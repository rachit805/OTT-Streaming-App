import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ott/model/reccomandedAlbumModel.dart';
import 'package:ott/model/spotify-services.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class PlayMusicScreen extends StatefulWidget {
  final String trackName;
  final String artistName;
  final String imageUrl;
  final String trackUrl;
  final String trackuri;
  final String artisturi;

  const PlayMusicScreen({
    Key? key,
    required this.trackName,
    required this.artistName,
    required this.imageUrl,
    required this.trackUrl,
    required this.trackuri,
    required this.artisturi,
  }) : super(key: key);

  @override
  _PlayMusicScreenState createState() => _PlayMusicScreenState();
}

class _PlayMusicScreenState extends State<PlayMusicScreen> {
  late StreamSubscription<PlayerState> playerStateSubscription =
      StreamController<PlayerState>.broadcast().stream.listen((_) {});
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isSeeking = false;
  bool connected = false;

  late Timer timer;
  late Future<ReccomandedAlbum?> reccomandedAlbum;

  @override
  void initState() {
    fetchReccomandation();
    super.initState();
    setAudio();
    reccomandedAlbum = fetchReccomandation();

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      updateUI();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    SpotifySdk.pause();
    playerStateSubscription.cancel();
    super.dispose();
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

  Future<void> setAudio() async {
    await SpotifySdk.play(spotifyUri: widget.trackuri);
  }

  Future<void> updateUI() async {
    PlayerState? playerState = await SpotifySdk.getPlayerState();
    if (playerState != null) {
      setState(() {
        duration = Duration(milliseconds: playerState.track?.duration ?? 0);
        position = Duration(milliseconds: playerState.playbackPosition);
        isPlaying = playerState.isPaused ? false : true;

        if (!isSeeking && position >= duration) {
          SpotifySdk.setShuffle(shuffle: false);
          SpotifySdk.skipNext();
        }
      });
    }
  }

  Future<void> togglePlayPause() async {
    try {
      if (isPlaying) {
        await SpotifySdk.pause();
      } else {
        await SpotifySdk.resume();
      }
    } catch (e) {
      print('Error: $e');
      await setAudio();
    }
  }

  Color iconColor = Colors.white;

  void toggleColor() {
    setState(() {
      iconColor = (iconColor == Colors.red) ? Colors.white : Colors.red;
    });
  }

  Future<void> skipNext() async {
    await SpotifySdk.skipNext();
  }

  Future<void> skipPrevious() async {
    await SpotifySdk.skipPrevious();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            expandedHeight: 200,
            flexibleSpace: _MySliverAppBar(
              imageUrl: widget.imageUrl,
              trackName: widget.trackName,
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    widget.trackName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Artist: ${widget.artistName}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      // width: MediaQuery.of(context).size.width,
                      height: 25,
                      child: Slider(
                        activeColor: const Color(0xFFF09047),
                        value: isSeeking
                            ? position.inMilliseconds.toDouble()
                            : position.inMilliseconds.toDouble(),
                        min: 0,
                        max: duration.inMilliseconds.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            isSeeking = true;
                            position = Duration(milliseconds: value.toInt());
                          });
                        },
                        onChangeEnd: (value) async {
                          await SpotifySdk.seekTo(
                              positionedMilliseconds: value.toInt());
                          setState(() {
                            isSeeking = false;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${position.inMinutes}:${(position.inSeconds % 60).toString().padLeft(2, '0')}',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '-${(duration - position).inMinutes}:${((duration - position).inSeconds % 60).toString().padLeft(2, '0')}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.shuffle),
                          onPressed: () {
                            // toggleColor();
                          },
                          iconSize: 20,
                          color: Colors.white,
                        ),
                        IconButton(
                          icon: const Icon(Icons.skip_previous),
                          onPressed: skipPrevious,
                          iconSize: 30,
                          color: Colors.white,
                        ),
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: Color(0xFFF09047),
                          child: IconButton(
                            icon: isPlaying
                                ? const Icon(Icons.pause)
                                : const Icon(Icons.play_arrow),
                            iconSize: 40,
                            color: Colors.black,
                            onPressed: togglePlayPause,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.skip_next,
                          ),
                          onPressed: skipNext,
                          iconSize: 30,
                          color: Colors.white,
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite),
                          onPressed: () {
                            toggleColor();
                          },
                          iconSize: 20,
                          color: iconColor,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Recommended",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              textAlign: TextAlign.left,
                              "Based on this song",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<ReccomandedAlbum?>(
                    future: reccomandedAlbum,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFF09047),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        ReccomandedAlbum? reccomandedAlbum = snapshot.data;

                        if (reccomandedAlbum == null) {
                          return Center(
                            child:
                                Text('Error: Received null data from the API.'),
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
                                  itemCount:
                                      reccomandedAlbum.tracks?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    Tracks? track =
                                        reccomandedAlbum.tracks?[index];
                                    Images? image = track?.album?.images?[0];
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: GestureDetector(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Builder(builder: (context) {
                                              return Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
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
            ),
          ),
        ],
      ),
    );
  }
}

class _MySliverAppBar extends StatelessWidget {
  final String imageUrl;
  final String trackName;

  _MySliverAppBar({
    required this.imageUrl,
    required this.trackName,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imageUrl,
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            height: 200,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF000000).withOpacity(
                      0.8), // Black color with high opacity at the top
                  Colors.transparent, // Transparent in the middle
                  Color(0xFF000000).withOpacity(
                      0.8), // Black color with high opacity at the bottom
                ],
              ),
            ),
          ),
        ),
        Positioned(
          child: Container(
            child: ListTile(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 25,
                ),
                color: Color(0xFFF09047),
              ),
              title: Text(
                trackName,
                // textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF09047),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
