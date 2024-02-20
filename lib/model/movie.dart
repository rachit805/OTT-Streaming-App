import 'dart:convert';

class Movie {
  bool? adult;
  String? backdropPath;
  int? id;
  String? title;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Movie({
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      adult: map['adult'] ?? false,
      backdropPath: map['backdrop_path'] ?? '',
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      originalLanguage: map['original_language'] ?? '',
      originalTitle: map['original_title'] ?? '',
      overview: map['overview'] ?? '',
      popularity: map['popularity'] ?? 0.0,
      posterPath: map['poster_path'] ?? '',
      releaseDate: map['release_date'] ?? '',
      video: map['video'] ?? false,
      voteAverage: map['vote_average'] ?? 0.0,
      voteCount: map['vote_count'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      adult: map['adult'] ?? false,
      backdropPath: map['backdrop_path'] ?? '',
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      originalLanguage: map['original_language'] ?? '',
      originalTitle: map['original_title'] ?? '',
      overview: map['overview'] ?? '',
      popularity: map['popularity'] ?? 0.0,
      posterPath: map['poster_path'] ?? '',
      releaseDate: map['release_date'] ?? '',
      video: map['video'] ?? false,
      voteAverage: map['vote_average'] ?? 0.0,
      voteCount: map['vote_count'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adult': adult,
      'backdrop_path': backdropPath,
      'id': id,
      'title': title,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'release_date': releaseDate,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }

  @override
  String toString() {
    return 'Movie(adult: $adult, backdropPath: $backdropPath, id: $id, title: $title, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, video: $video, voteAverage: $voteAverage, voteCount: $voteCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movie &&
        other.adult == adult &&
        other.backdropPath == backdropPath &&
        other.id == id &&
        other.title == title &&
        other.originalLanguage == originalLanguage &&
        other.originalTitle == originalTitle &&
        other.overview == overview &&
        other.popularity == popularity &&
        other.posterPath == posterPath &&
        other.releaseDate == releaseDate &&
        other.video == video &&
        other.voteAverage == voteAverage &&
        other.voteCount == voteCount;
  }

  @override
  int get hashCode {
    return adult.hashCode ^
        backdropPath.hashCode ^
        id.hashCode ^
        title.hashCode ^
        originalLanguage.hashCode ^
        originalTitle.hashCode ^
        overview.hashCode ^
        popularity.hashCode ^
        posterPath.hashCode ^
        releaseDate.hashCode ^
        video.hashCode ^
        voteAverage.hashCode ^
        voteCount.hashCode;
  }
}
