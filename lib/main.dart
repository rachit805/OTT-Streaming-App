import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:ott/model/spotify-services.dart';
import 'package:ott/screens/homepage.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // VlcPlayerController.setMediaController(() => VlcMediaController());

  await SpotifyService.connectToSpotifyRemote();
  final authenticationToken = await SpotifyService.getAuthenticationToken();
  if (authenticationToken != null) {
    print('User is authenticated. Token: $authenticationToken');
  } else {
    print('User is not authenticated.');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
