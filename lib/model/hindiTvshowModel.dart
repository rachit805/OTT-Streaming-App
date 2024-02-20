class HindiTvShow {
  final int id;
  final String name;
  final String overview;
  final double voteAverage;
  final String posterPath;

  HindiTvShow({
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
    required this.posterPath,
  });

  factory HindiTvShow.fromJson(Map<String, dynamic> json) {
    return HindiTvShow(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      voteAverage: json['vote_average'].toDouble(),
      posterPath: json['poster_path'],
    );
  }
}
