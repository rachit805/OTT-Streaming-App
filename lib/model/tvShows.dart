class TVShow {
  String epguidesName;
  String epguidesUrl;
  String episodes;
  String firstEpisode;
  String lastEpisode;
  String nextEpisode;

  TVShow({
    required this.epguidesName,
    required this.epguidesUrl,
    required this.episodes,
    required this.firstEpisode,
    required this.lastEpisode,
    required this.nextEpisode,
  });

  factory TVShow.fromJson(Map<String, dynamic> json) {
    try {
      return TVShow(
        epguidesName: json['epguides_name'] ?? '',
        epguidesUrl: json['epguides_url'] ?? '',
        episodes: json['episodes'] ?? '',
        firstEpisode: json['first_episode'] ?? '',
        lastEpisode: json['last_episode'] ?? '',
        nextEpisode: json['next_episode'] ?? '',
      );
    } catch (e) {
      // Handle parsing errors
      print('Error parsing TVShow from JSON: $e');
      return TVShow(
        epguidesName: '',
        epguidesUrl: '',
        episodes: '',
        firstEpisode: '',
        lastEpisode: '',
        nextEpisode: '',
      );
    }
  }

  @override
  String toString() {
    return 'TVShow{epguidesName: $epguidesName, epguidesUrl: $epguidesUrl, episodes: $episodes, firstEpisode: $firstEpisode, lastEpisode: $lastEpisode, nextEpisode: $nextEpisode}';
  }
}
