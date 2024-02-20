import 'package:flutter/material.dart';
import 'package:ott/model/kidsAnimeModel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class KidsAnimeDetails extends StatefulWidget {
  const KidsAnimeDetails({Key? key, required this.kidsModel}) : super(key: key);
  final KidsAnimeModel kidsModel;

  @override
  State<KidsAnimeDetails> createState() => _KidsAnimeDetailsState();
}

class _KidsAnimeDetailsState extends State<KidsAnimeDetails> {
  late YoutubePlayerController _controller;
  late String videoUrl;

  @override
  void initState() {
    super.initState();
    videoUrl = widget.kidsModel.trailer?['url'] ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl) ?? '',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
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
          "${widget.kidsModel.title}",
          style: TextStyle(
            color: Color(0xFFF09047),
            fontSize: 25,
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    if (videoUrl.isNotEmpty)
                      YoutubePlayer(
                        controller: _controller,
                        liveUIColor: Colors.amber,
                      )
                    else
                      Center(
                        child: Text(
                          'No video available',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    SizedBox(height: 10),
                    Text(
                      "${widget.kidsModel.trailer?['url'] ?? 'No video available'}",
                      style: TextStyle(
                        color: Color(0xFFF09047),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
