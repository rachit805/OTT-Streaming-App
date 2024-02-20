class Anime {
  String id;
  String title;
  List<String> alternativeTitles;
  int ranking;
  List<String> genres;
  int episodes;
  bool hasEpisode;
  bool hasRanking;
  String image;
  String link;
  String status;
  String synopsis;
  String thumb;
  String type;

  Anime({
    required this.id,
    required this.title,
    required this.alternativeTitles,
    required this.ranking,
    required this.genres,
    required this.episodes,
    required this.hasEpisode,
    required this.hasRanking,
    required this.image,
    required this.link,
    required this.status,
    required this.synopsis,
    required this.thumb,
    required this.type,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['_id'],
      title: json['title'],
      alternativeTitles: List<String>.from(json['alternativeTitles']),
      ranking: json['ranking'],
      genres: List<String>.from(json['genres']),
      episodes: json['episodes'],
      hasEpisode: json['hasEpisode'],
      hasRanking: json['hasRanking'],
      image: json['image'],
      link: json['link'],
      status: json['status'],
      synopsis: json['synopsis'],
      thumb: json['thumb'],
      type: json['type'],
    );
  }
}
