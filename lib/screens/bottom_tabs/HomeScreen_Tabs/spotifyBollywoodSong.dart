import 'package:flutter/material.dart';
import 'package:ott/model/spotify-services.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: SpotifyService.getTop50BollywoodMusic(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return buildPlaylistDetails(snapshot.data);
          }
        },
      ),
    );
  }

  Widget buildPlaylistDetails(Map<String, dynamic>? playlistData) {
    if (playlistData == null) {
      return Center(child: Text('Failed to load playlist data.'));
    }

    return ListView(
      children: <Widget>[
        ListTile(
          title: Text('Playlist Name: ${playlistData['name']}'),
        ),
        ListTile(
          title: Text('Number of Tracks: ${playlistData['tracks']['total']}'),
        ),
        ListTile(
          title: Text('Number of Tracks: ${playlistData['tracks']['name']}'),
        ),
      ],
    );
  }
}
