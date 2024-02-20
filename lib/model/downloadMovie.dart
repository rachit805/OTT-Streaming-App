// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DownloadableMovies {
  final int index;
  final String title;
  final String coverPhotoLink;
  final String description;
  final String size;
  final int year;
  final bool isSeries;
  final String uploadDate;
  final String source;
  final String downloadLink;
  final String sDownloadLink;

  DownloadableMovies({
    required this.index,
    required this.title,
    required this.coverPhotoLink,
    required this.description,
    required this.size,
    required this.year,
    required this.isSeries,
    required this.uploadDate,
    required this.source,
    required this.downloadLink,
    required this.sDownloadLink,
  });

  factory DownloadableMovies.fromJson(Map<String, dynamic> json) {
    return DownloadableMovies(
      index: json['Index'] ?? 0,
      title: json['Title'] ?? '',
      coverPhotoLink: json['CoverPhotoLink'] ?? '',
      description: json['Description'] ?? '',
      size: json['Size'] ?? '',
      year: json['Year'] ?? 0,
      isSeries: json['IsSeries'] ?? false,
      uploadDate: json['UploadDate'] ?? '',
      source: json['Source'] ?? '',
      downloadLink: json['DownloadLink'] ?? '',
      sDownloadLink: json['SDownloadLink'] ?? '',
    );
  }

  DownloadableMovies copyWith({
    int? index,
    String? title,
    String? coverPhotoLink,
    String? description,
    String? size,
    int? year,
    bool? isSeries,
    String? uploadDate,
    String? source,
    String? downloadLink,
    String? sDownloadLink,
  }) {
    return DownloadableMovies(
      index: index ?? this.index,
      title: title ?? this.title,
      coverPhotoLink: coverPhotoLink ?? this.coverPhotoLink,
      description: description ?? this.description,
      size: size ?? this.size,
      year: year ?? this.year,
      isSeries: isSeries ?? this.isSeries,
      uploadDate: uploadDate ?? this.uploadDate,
      source: source ?? this.source,
      downloadLink: downloadLink ?? this.downloadLink,
      sDownloadLink: sDownloadLink ?? this.sDownloadLink,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'index': index,
      'title': title,
      'coverPhotoLink': coverPhotoLink,
      'description': description,
      'size': size,
      'year': year,
      'isSeries': isSeries,
      'uploadDate': uploadDate,
      'source': source,
      'downloadLink': downloadLink,
      'sDownloadLink': sDownloadLink,
    };
  }

  factory DownloadableMovies.fromMap(Map<String, dynamic> map) {
    return DownloadableMovies(
      index: map['index'] as int,
      title: map['title'] as String,
      coverPhotoLink: map['coverPhotoLink'] as String,
      description: map['description'] as String,
      size: map['size'] as String,
      year: map['year'] as int,
      isSeries: map['isSeries'] as bool,
      uploadDate: map['uploadDate'] as String,
      source: map['source'] as String,
      downloadLink: map['downloadLink'] as String,
      sDownloadLink: map['sDownloadLink'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'DownloadableMovies(index: $index, title: $title, coverPhotoLink: $coverPhotoLink, description: $description, size: $size, year: $year, isSeries: $isSeries, uploadDate: $uploadDate, source: $source, downloadLink: $downloadLink, sDownloadLink: $sDownloadLink)';
  }

  @override
  bool operator ==(covariant DownloadableMovies other) {
    if (identical(this, other)) return true;

    return other.index == index &&
        other.title == title &&
        other.coverPhotoLink == coverPhotoLink &&
        other.description == description &&
        other.size == size &&
        other.year == year &&
        other.isSeries == isSeries &&
        other.uploadDate == uploadDate &&
        other.source == source &&
        other.downloadLink == downloadLink &&
        other.sDownloadLink == sDownloadLink;
  }

  @override
  int get hashCode {
    return index.hashCode ^
        title.hashCode ^
        coverPhotoLink.hashCode ^
        description.hashCode ^
        size.hashCode ^
        year.hashCode ^
        isSeries.hashCode ^
        uploadDate.hashCode ^
        source.hashCode ^
        downloadLink.hashCode ^
        sDownloadLink.hashCode;
  }
}
