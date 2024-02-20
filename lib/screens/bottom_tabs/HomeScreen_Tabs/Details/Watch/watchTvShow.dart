// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WatchTvShow extends StatefulWidget {
  const WatchTvShow({
    Key? key,
    required this.showId,
    required this.showName,
    required this.season,
    required this.episode,
  }) : super(key: key);
  final String showId;
  final String showName;
  final String season;
  final String episode;

  @override
  State<WatchTvShow> createState() => _WatchTvShowState();
}

late InAppWebViewController _webViewController;
bool isLoading = true;

Future<NavigationActionPolicy?> _shouldOverrideUrlLoading(
    InAppWebViewController controller, NavigationAction action) async {
  String url = action.request.url.toString().toLowerCase();

  // Check for unwanted keywords in the URL
  if (url.contains('ads') ||
      url.contains('popup') ||
      url.contains('ad.doubleclick.net') ||
      url.contains('adclick') ||
      url.contains('advert') ||
      url.contains('banner') ||
      url.contains('click') ||
      url.contains('track')) {
    return NavigationActionPolicy.CANCEL;
  }

  // Check for explicit keywords indicating pop-ups
  if (url.contains('alert') ||
      url.contains('confirm') ||
      url.contains('prompt') ||
      url.contains('open')) {
    return NavigationActionPolicy.CANCEL;
  }
  if (url.startsWith('https://www.youtube.com/')) {
    return NavigationActionPolicy.CANCEL;
  }

  // Check if the HTML content contains the <iframe> tag
  var htmlContent =
      await controller.evaluateJavascript(source: "document.body.innerHTML");
  if (htmlContent.toLowerCase().contains('<iframe')) {
    return NavigationActionPolicy.CANCEL;
  }

  return NavigationActionPolicy.ALLOW;
}

class _WatchTvShowState extends State<WatchTvShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFF09047)),
        backgroundColor: Colors.black,
        // title: Text(
        //   widget.movieName,
        //   style:
        //       TextStyle(color: Color(0xFFF09047), fontWeight: FontWeight.w500),
        // ),
        // centerTitle: true,
      ),
      backgroundColor: Colors.black12,
      body: Column(
        children: [
          Container(
            height: 30,
            decoration: BoxDecoration(color: Color(0xFFF09047)),
            alignment: Alignment.center,
            child: Text(
              "To Handle Ads/Errors, Go Back and Replay the Video!",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: Uri.parse(
                      "https://vidsrc.xyz/embed/tv/${widget.showId}/${widget.season}${widget.episode}",
                    ),
                  ),
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      javaScriptEnabled: true,
                      useShouldOverrideUrlLoading: true,
                    ),
                  ),
                  shouldOverrideUrlLoading: _shouldOverrideUrlLoading,
                  onLoadStart: (controller, url) {
                    setState(() {
                      isLoading = true;
                    });
                  },
                  onLoadStop: (controller, url) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
                if (isLoading)
                  CircularProgressIndicator(
                    color: Color(0xFFF09047),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


//https://vidsrc.xyz/embed/movie/tv?imdb==tt0944947&season=1&episode=5