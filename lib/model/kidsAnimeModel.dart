class KidsAnimeModel {
  final String title;
  final String image;
  final Map<String, dynamic>? trailer;

  KidsAnimeModel({
    required this.title,
    required this.image,
    this.trailer,
  });

  factory KidsAnimeModel.fromJson(Map<String, dynamic> json) {
    return KidsAnimeModel(
      title: json['title'] ?? '',
      image: json['images']['jpg']['image_url'] ?? '',
      trailer: json['trailer'],
    );
  }
}
