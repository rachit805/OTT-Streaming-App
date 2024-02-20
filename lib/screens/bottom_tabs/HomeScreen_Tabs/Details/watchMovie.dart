import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WatchMovie extends StatefulWidget {
  const WatchMovie({Key? key, required this.movieId, required this.movieName})
      : super(key: key);

  final String movieId;
  final String movieName;

  @override
  State<WatchMovie> createState() => _WatchMovieState();
}

class _WatchMovieState extends State<WatchMovie> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFF09047)),
        backgroundColor: Colors.black,
        title: Text(
          widget.movieName,
          style:
              TextStyle(color: Color(0xFFF09047), fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
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
                        'https://vidsrc.xyz/embed/movie/${widget.movieId}'),
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
