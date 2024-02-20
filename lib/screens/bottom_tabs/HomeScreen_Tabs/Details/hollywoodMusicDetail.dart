import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:ott/model/hollywoodmusic.dart';

class MusicDetailPage extends StatefulWidget {
  MusicDetailPage({
    Key? key,
    required this.musicList,
    required this.initialIndex,
  }) : super(key: key);

  final List<HollywoodMusic> musicList;
  final int initialIndex;

  @override
  State<MusicDetailPage> createState() => _MusicDetailPageState();
}

class _MusicDetailPageState extends State<MusicDetailPage> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isSeeking = false;
  late int currentIndex;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    pageController = PageController(initialPage: currentIndex);
    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      // Check if the player is currently seeking, if so, don't update position
      if (!isSeeking) {
        setState(() {
          position = newPosition;
        });
      }
    });
  }

  Color favColor = Colors.white;
  Color shuffleColor = Colors.white;

  void AddFavColor() {
    setState(() {
      favColor =
          (favColor == Color(0xFFF09047)) ? Colors.white : Color(0xFFF09047);
    });
  }

  void AddShuffleColor() {
    setState(() {
      shuffleColor = (shuffleColor == Color(0xFFF09047))
          ? Colors.white
          : Color(0xFFF09047);
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFFF09047)),
        backgroundColor: Colors.black,
        title: Text(
          widget.musicList[currentIndex].title.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF09047),
          ),
        ),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity! > 0) {
            playPreviousSong();
          } else {
            stopMusic(); // Stop music before going to the next song
            playNextSong();
          }
        },
        child: PageView.builder(
          controller: pageController,
          itemCount: widget.musicList.length,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
              setAudio();
            });
          },
          itemBuilder: (context, index) {
            return buildPage(index);
          },
        ),
      ),
    );
  }

  Widget buildPage(int index) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              height: MediaQuery.of(context).size.height / 2.75,
              widget.musicList[index].image.toString(),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.musicList[index].title.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.musicList[index].artist.toString(),
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
          const SizedBox(height: 15),
          Container(
            height: 30,
            child: Slider(
              value: position.inSeconds.toDouble(),
              min: 0,
              activeColor: const Color(0xFFF09047),
              max: duration.inSeconds.toDouble(),
              onChanged: (value) async {
                setState(() {
                  isSeeking = true;
                });
                final position = Duration(seconds: value.toInt());
                await audioPlayer.seek(position);
                await audioPlayer.resume();
              },
              onChangeEnd: (value) {
                setState(() {
                  isSeeking = false;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatTime(position),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  formatTime(duration - position),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.shuffle),
                onPressed: () {
                  AddShuffleColor();
                },
                iconSize: 20,
                color: shuffleColor,
              ),
              IconButton(
                icon: Icon(
                  Icons.skip_previous,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  playPreviousSong();
                },
              ),
              CircleAvatar(
                backgroundColor: const Color(0xFFF09047),
                radius: 24,
                child: Center(
                  child: IconButton(
                    onPressed: () async {
                      if (isPlaying) {
                        await audioPlayer.pause();
                      } else {
                        await audioPlayer.resume();
                      }
                    },
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.skip_next,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  stopMusic();
                  playNextSong();
                },
              ),
              IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () {
                  AddFavColor();
                },
                iconSize: 20,
                color: favColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    await audioPlayer
        .setSourceUrl(widget.musicList[currentIndex].source.toString());
  }

  Future<void> playNextSong() async {
    int nextIndex = (currentIndex + 1) % widget.musicList.length;
    pageController.animateToPage(
      nextIndex,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> playPreviousSong() async {
    int previousIndex =
        (currentIndex - 1 + widget.musicList.length) % widget.musicList.length;
    pageController.animateToPage(
      previousIndex,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> stopMusic() async {
    await audioPlayer.stop();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hours = twoDigits(duration.inHours);
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, twoDigitMinutes, twoDigitSeconds]
        .join(':');
  }
}
