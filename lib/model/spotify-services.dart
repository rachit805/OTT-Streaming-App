import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ott/model/artistsModel.dart';
import 'package:ott/model/featuredPlaylists.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class SpotifyService {
  static const clientId = '13517b6ccfe54773bedfb00ddc9e96c0';
  static const redirectUri = 'http://localhost:8888/callback';
  static const scope =
      "app-remote-control,user-modify-playback-state,playlist-read-private";
  static Future<void> connectToSpotifyRemote() async {
    try {
      await SpotifySdk.connectToSpotifyRemote(
        clientId: clientId,
        redirectUrl: redirectUri,
        scope: scope,
      );
    } catch (e) {
      // Handle connection errors
      print('Failed to connect to Spotify: $e');
    }
  }

  static Future<String?> getAuthenticationToken() async {
    try {
      final authenticationToken = await SpotifySdk.getAuthenticationToken(
        clientId: clientId,
        redirectUrl: redirectUri,
        scope: scope,
      );

      print('Authentication Token: $authenticationToken');
      return authenticationToken ?? '';
    } catch (e) {
      print('Failed to get authentication token: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>> getTop50BollywoodMusic() async {
    try {
      await connectToSpotifyRemote();

      final authenticationToken = await getAuthenticationToken();

      if (authenticationToken != null) {
        print('Fetching playlist with token: $authenticationToken');

        final response = await http.get(
          Uri.parse(
              'https://api.spotify.com/v1/playlists/37i9dQZEVXbMWDif5SCBJq'),
          headers: {
            'Authorization': 'Bearer $authenticationToken',
          },
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> top50BollywoodMusicData =
              jsonDecode(response.body);
          print('Playlist Name: ${top50BollywoodMusicData['name']}');
          print(
              'Number of Tracks: ${top50BollywoodMusicData['tracks']['total']}');
          return top50BollywoodMusicData;
        } else {
          throw Exception(
              'Failed to get playlist. Status Code: ${response.statusCode}');
        }
      } else {
        throw Exception(
            'Authentication token is null. Unable to get playlist.');
      }
    } catch (e) {
      print('Failed to get playlist: $e');
      rethrow;
    }
  }

  Future<FeaturedPlaylists?> fetchFeaturedPlaylists() async {
    String apiUrl = 'https://api.spotify.com/v1/browse/featured-playlists';

    try {
      final authenticationToken = await SpotifyService.getAuthenticationToken();

      final response = await http.get(Uri.parse(apiUrl), headers: {
        'Authorization': 'Bearer $authenticationToken',
      });

      if (response.statusCode == 200) {
        final jsonResult = json.decode(response.body);
        print("FeturedPlaylist data decoded");
        return FeaturedPlaylists.fromJson(jsonResult);
      } else {
        print('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  Future<ArtistsData?> fetchArtistsData([String? authenticationToken]) async {
    String apiUrl =
        'https://api.spotify.com/v1/artists?ids=4IKVDbCSBTxBeAsMKjAuTs%2C4YRxDV8wJFPHPTeXepOstw%2C2oSONSC9zQ4UonDKnLqksx%2C7vk5e3vY1uw9plTHJAMwjN%2C5ZsFI1h6hIdQRw2ti0hz81%2C1mYsTxnqsietFxj1OgoGbG%2C2CIMQHirSU0MQqyYHq0eOx%2C57dN52uHvrHOxijzpIgu3E%2C1vCWHaC5f2uS3yhpwWbIA6';

    try {
      final authenticationToken = await SpotifyService.getAuthenticationToken();

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $authenticationToken'},
      );

      if (response.statusCode == 200) {
        final jsonResult = json.decode(response.body);
        print("Artists data decoded");
        print(response.body);

        ArtistsData artistsData = ArtistsData.fromJson(jsonResult);
        return artistsData;
      } else {
        print('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }
}
