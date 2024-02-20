class KidsModel {
  String status;
  String baseUrl;
  KidsHome home;

  KidsModel({
    required this.status,
    required this.baseUrl,
    required this.home,
  });

  factory KidsModel.fromJson(Map<String, dynamic> json) {
    print("Rachit");
    return KidsModel(
      status:
          json['status'] ?? "", // Provide a default value if 'status' is null
      baseUrl:
          json['baseUrl'] ?? "", // Provide a default value if 'baseUrl' is null
      home: KidsHome.fromJson(json['home'] ?? {}),
    );
  }
}

class KidsHome {
  List<KidsEntry> onGoing;
  List<KidsEntry> complete;

  KidsHome({
    required this.onGoing,
    required this.complete,
  });

  factory KidsHome.fromJson(Map<String, dynamic> json) {
    return KidsHome(
      onGoing: List<KidsEntry>.from(
        (json['on_going'] as List<dynamic>? ?? [])
            .map((entry) => KidsEntry.fromJson(entry)),
      ),
      complete: List<KidsEntry>.from(
        (json['complete'] as List<dynamic>? ?? [])
            .map((entry) => KidsEntry.fromJson(entry)),
      ),
    );
  }
}

class KidsEntry {
  String title;
  String id;
  String thumb;
  String episode;
  String uploadedOn;
  String dayUpdated;
  String link;
  double? score; // This field is only present in the 'complete' section

  KidsEntry({
    required this.title,
    required this.id,
    required this.thumb,
    required this.episode,
    required this.uploadedOn,
    required this.dayUpdated,
    required this.link,
    this.score,
  });

  factory KidsEntry.fromJson(Map<String, dynamic> json) {
    return KidsEntry(
      title: json['title'] ?? "", // Provide a default value if 'title' is null
      id: json['id'] ?? "", // Provide a default value if 'id' is null
      thumb: json['thumb'] ?? "", // Provide a default value if 'thumb' is null
      episode:
          json['episode'] ?? "", // Provide a default value if 'episode' is null
      uploadedOn: json['uploaded_on'] ??
          "", // Provide a default value if 'uploaded_on' is null
      dayUpdated: json['day_updated'] ??
          "", // Provide a default value if 'day_updated' is null
      link: json['link'] ?? "", // Provide a default value if 'link' is null
      score: json['score'] != null ? json['score'].toDouble() : null,
    );
  }
}
