class ChartEntry {
  int currentRank;
  int previousRank;
  int peakRank;
  String peakDate;
  int appearancesOnChart;
  int consecutiveAppearancesOnChart;
  TrackMetadata trackMetadata;

  ChartEntry({
    required this.currentRank,
    required this.previousRank,
    required this.peakRank,
    required this.peakDate,
    required this.appearancesOnChart,
    required this.consecutiveAppearancesOnChart,
    required this.trackMetadata,
  });

  factory ChartEntry.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('Received null JSON data for ChartEntry');
    }

    return ChartEntry(
      currentRank: json['currentRank'] as int? ?? 0,
      previousRank: json['previousRank'] as int? ?? 0,
      peakRank: json['peakRank'] as int? ?? 0,
      peakDate: json['peakDate'] as String? ?? '',
      appearancesOnChart: json['appearancesOnChart'] as int? ?? 0,
      consecutiveAppearancesOnChart:
          json['consecutiveAppearancesOnChart'] as int? ?? 0,
      trackMetadata: TrackMetadata.fromJson(json['trackMetadata']),
    );
  }
}

class TrackMetadata {
  String trackName;
  String trackUri;
  String displayImageUri;
  String releaseDate;

  TrackMetadata({
    required this.trackName,
    required this.trackUri,
    required this.displayImageUri,
    required this.releaseDate,
  });

  factory TrackMetadata.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('Received null JSON data for TrackMetadata');
    }

    return TrackMetadata(
      trackName: json['trackName'] as String? ?? '',
      trackUri: json['trackUri'] as String? ?? '',
      displayImageUri: json['displayImageUri'] as String? ?? '',
      releaseDate: json['releaseDate'] as String? ?? '',
    );
  }
}
