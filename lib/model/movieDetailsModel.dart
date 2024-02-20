class MovieDetails {
  Movie? movie;
  List<SimilarMovies>? similarMovies;

  MovieDetails({this.movie, this.similarMovies});

  MovieDetails.fromJson(Map<String, dynamic> json) {
    movie = json['movie'] != null ? new Movie.fromJson(json['movie']) : null;
    if (json['similarMovies'] != null) {
      similarMovies = <SimilarMovies>[];
      json['similarMovies'].forEach((v) {
        similarMovies!.add(new SimilarMovies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.movie != null) {
      data['movie'] = this.movie!.toJson();
    }
    if (this.similarMovies != null) {
      data['similarMovies'] =
          this.similarMovies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Movie {
  int? iId;
  String? backdropPath;
  List<String>? genres;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? releaseDate;
  String? title;
  double? voteAverage;
  int? voteCount;
  String? youtubeTrailer;
  List<Sources>? sources;

  Movie(
      {this.iId,
      this.backdropPath,
      this.genres,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.voteAverage,
      this.voteCount,
      this.youtubeTrailer,
      this.sources});

  Movie.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    backdropPath = json['backdrop_path'];
    genres = json['genres'].cast<String>();
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    youtubeTrailer = json['youtube_trailer'];
    if (json['sources'] != null) {
      sources = <Sources>[];
      json['sources'].forEach((v) {
        sources!.add(new Sources.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['backdrop_path'] = this.backdropPath;
    data['genres'] = this.genres;
    data['original_title'] = this.originalTitle;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    data['release_date'] = this.releaseDate;
    data['title'] = this.title;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    data['youtube_trailer'] = this.youtubeTrailer;
    if (this.sources != null) {
      data['sources'] = this.sources!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sources {
  String? source;
  String? link;
  String? type;
  String? displayName;
  String? info;
  Platform? platform;

  Sources(
      {this.source,
      this.link,
      this.type,
      this.displayName,
      this.info,
      this.platform});

  Sources.fromJson(Map<String, dynamic> json) {
    source = json['source'];
    link = json['link'];
    type = json['type'];
    displayName = json['display_name'];
    info = json['info'];
    platform = json['platform'] != null
        ? new Platform.fromJson(json['platform'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source'] = this.source;
    data['link'] = this.link;
    data['type'] = this.type;
    data['display_name'] = this.displayName;
    data['info'] = this.info;
    if (this.platform != null) {
      data['platform'] = this.platform!.toJson();
    }
    return data;
  }
}

class Platform {
  String? android;
  String? androidTv;
  String? ios;
  String? web;

  Platform({this.android, this.androidTv, this.ios, this.web});

  Platform.fromJson(Map<String, dynamic> json) {
    android = json['android'];
    androidTv = json['android_tv'];
    ios = json['ios'];
    web = json['web'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['android'] = this.android;
    data['android_tv'] = this.androidTv;
    data['ios'] = this.ios;
    data['web'] = this.web;
    return data;
  }
}

class SimilarMovies {
  int? iId;
  String? backdropPath;
  List<String>? genres;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? releaseDate;
  String? title;
  String? contentType;

  SimilarMovies(
      {this.iId,
      this.backdropPath,
      this.genres,
      this.originalTitle,
      this.overview,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.contentType});

  SimilarMovies.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    backdropPath = json['backdrop_path'];
    genres = json['genres'].cast<String>();
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    contentType = json['contentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['backdrop_path'] = this.backdropPath;
    data['genres'] = this.genres;
    data['original_title'] = this.originalTitle;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    data['release_date'] = this.releaseDate;
    data['title'] = this.title;
    data['contentType'] = this.contentType;
    return data;
  }
}
