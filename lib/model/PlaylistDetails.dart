class PlaylistDetails {
  bool? collaborative;
  ExternalUrls? externalUrls;
  Followers? followers;
  String? href;
  String? id;
  List<Images>? images;
  String? primaryColor;
  String? name;
  String? description;
  String? type;
  String? uri;
  Owner? owner;
  bool? public;
  String? snapshotId;
  Tracks? tracks;

  PlaylistDetails(
      {this.collaborative,
      this.externalUrls,
      this.followers,
      this.href,
      this.id,
      this.images,
      this.primaryColor,
      this.name,
      this.description,
      this.type,
      this.uri,
      this.owner,
      this.public,
      this.snapshotId,
      this.tracks});

  PlaylistDetails.fromJson(Map<String, dynamic> json) {
    collaborative = json['collaborative'];
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    followers = json['followers'] != null
        ? new Followers.fromJson(json['followers'])
        : null;
    href = json['href'];
    id = json['id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    primaryColor = json['primary_color'];
    name = json['name'];
    description = json['description'];
    type = json['type'];
    uri = json['uri'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    public = json['public'];
    snapshotId = json['snapshot_id'];
    tracks =
        json['tracks'] != null ? new Tracks.fromJson(json['tracks']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collaborative'] = this.collaborative;
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    if (this.followers != null) {
      data['followers'] = this.followers!.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['primary_color'] = this.primaryColor;
    data['name'] = this.name;
    data['description'] = this.description;
    data['type'] = this.type;
    data['uri'] = this.uri;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['public'] = this.public;
    data['snapshot_id'] = this.snapshotId;
    if (this.tracks != null) {
      data['tracks'] = this.tracks!.toJson();
    }
    return data;
  }
}

class ExternalUrls {
  String? spotify;

  ExternalUrls({this.spotify});

  ExternalUrls.fromJson(Map<String, dynamic> json) {
    spotify = json['spotify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spotify'] = this.spotify;
    return data;
  }
}

class Followers {
  Null? href;
  int? total;

  Followers({this.href, this.total});

  Followers.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['total'] = this.total;
    return data;
  }
}

class Images {
  String? url;
  int? height; // Change from Null to int?
  int? width; // Change from Null to int?

  Images({this.url, this.height, this.width});

  Images.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    height = json['height'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['height'] = this.height;
    data['width'] = this.width;
    return data;
  }
}

class Owner {
  String? href;
  String? id;
  String? type;
  String? uri;
  String? displayName;
  ExternalUrls? externalUrls;

  Owner(
      {this.href,
      this.id,
      this.type,
      this.uri,
      this.displayName,
      this.externalUrls});

  Owner.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    id = json['id'];
    type = json['type'];
    uri = json['uri'];
    displayName = json['display_name'];
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['id'] = this.id;
    data['type'] = this.type;
    data['uri'] = this.uri;
    data['display_name'] = this.displayName;
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    return data;
  }
}

class Tracks {
  int? limit;
  Null? next;
  int? offset;
  Null? previous;
  String? href;
  int? total;
  List<Items>? items;

  Tracks(
      {this.limit,
      this.next,
      this.offset,
      this.previous,
      this.href,
      this.total,
      this.items});

  Tracks.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    next = json['next'];
    offset = json['offset'];
    previous = json['previous'];
    href = json['href'];
    total = json['total'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['next'] = this.next;
    data['offset'] = this.offset;
    data['previous'] = this.previous;
    data['href'] = this.href;
    data['total'] = this.total;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? addedAt;
  Null? primaryColor;
  VideoThumbnail? videoThumbnail;
  bool? isLocal;
  AddedBy? addedBy;
  Track? track;

  Items(
      {this.addedAt,
      this.primaryColor,
      this.videoThumbnail,
      this.isLocal,
      this.addedBy,
      this.track});

  Items.fromJson(Map<String, dynamic> json) {
    addedAt = json['added_at'];
    primaryColor = json['primary_color'];
    videoThumbnail = json['video_thumbnail'] != null
        ? new VideoThumbnail.fromJson(json['video_thumbnail'])
        : null;
    isLocal = json['is_local'];
    addedBy = json['added_by'] != null
        ? new AddedBy.fromJson(json['added_by'])
        : null;
    track = json['track'] != null ? new Track.fromJson(json['track']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['added_at'] = this.addedAt;
    data['primary_color'] = this.primaryColor;
    if (this.videoThumbnail != null) {
      data['video_thumbnail'] = this.videoThumbnail!.toJson();
    }
    data['is_local'] = this.isLocal;
    if (this.addedBy != null) {
      data['added_by'] = this.addedBy!.toJson();
    }
    if (this.track != null) {
      data['track'] = this.track!.toJson();
    }
    return data;
  }
}

class VideoThumbnail {
  Null? url;

  VideoThumbnail({this.url});

  VideoThumbnail.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class AddedBy {
  ExternalUrls? externalUrls;
  String? id;
  String? type;
  String? uri;
  String? href;

  AddedBy({this.externalUrls, this.id, this.type, this.uri, this.href});

  AddedBy.fromJson(Map<String, dynamic> json) {
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    id = json['id'];
    type = json['type'];
    uri = json['uri'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    data['id'] = this.id;
    data['type'] = this.type;
    data['uri'] = this.uri;
    data['href'] = this.href;
    return data;
  }
}

class Track {
  String? previewUrl;
  List<String>? availableMarkets;
  bool? explicit;
  String? type;
  bool? episode;
  bool? track;
  Album? album;
  List<Artists>? artists;
  int? discNumber;
  int? trackNumber;
  int? durationMs;
  ExternalIds? externalIds;
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  String? name;
  int? popularity;
  String? uri;
  bool? isLocal;

  Track(
      {this.previewUrl,
      this.availableMarkets,
      this.explicit,
      this.type,
      this.episode,
      this.track,
      this.album,
      this.artists,
      this.discNumber,
      this.trackNumber,
      this.durationMs,
      this.externalIds,
      this.externalUrls,
      this.href,
      this.id,
      this.name,
      this.popularity,
      this.uri,
      this.isLocal});

  Track.fromJson(Map<String, dynamic> json) {
    previewUrl = json['preview_url'];
    availableMarkets = json['available_markets'].cast<String>();
    explicit = json['explicit'];
    type = json['type'];
    episode = json['episode'];
    track = json['track'];
    album = json['album'] != null ? new Album.fromJson(json['album']) : null;
    if (json['artists'] != null) {
      artists = <Artists>[];
      json['artists'].forEach((v) {
        artists!.add(new Artists.fromJson(v));
      });
    }
    discNumber = json['disc_number'];
    trackNumber = json['track_number'];
    durationMs = json['duration_ms'];
    externalIds = json['external_ids'] != null
        ? new ExternalIds.fromJson(json['external_ids'])
        : null;
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    name = json['name'];
    popularity = json['popularity'];
    uri = json['uri'];
    isLocal = json['is_local'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['preview_url'] = this.previewUrl;
    data['available_markets'] = this.availableMarkets;
    data['explicit'] = this.explicit;
    data['type'] = this.type;
    data['episode'] = this.episode;
    data['track'] = this.track;
    if (this.album != null) {
      data['album'] = this.album!.toJson();
    }
    if (this.artists != null) {
      data['artists'] = this.artists!.map((v) => v.toJson()).toList();
    }
    data['disc_number'] = this.discNumber;
    data['track_number'] = this.trackNumber;
    data['duration_ms'] = this.durationMs;
    if (this.externalIds != null) {
      data['external_ids'] = this.externalIds!.toJson();
    }
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    data['name'] = this.name;
    data['popularity'] = this.popularity;
    data['uri'] = this.uri;
    data['is_local'] = this.isLocal;
    return data;
  }
}

class Album {
  List<String>? availableMarkets;
  String? type;
  String? albumType;
  String? href;
  String? id;
  List<Images>? images;
  String? name;
  String? releaseDate;
  String? releaseDatePrecision;
  String? uri;
  List<Artists>? artists;
  ExternalUrls? externalUrls;
  int? totalTracks;

  Album(
      {this.availableMarkets,
      this.type,
      this.albumType,
      this.href,
      this.id,
      this.images,
      this.name,
      this.releaseDate,
      this.releaseDatePrecision,
      this.uri,
      this.artists,
      this.externalUrls,
      this.totalTracks});

  Album.fromJson(Map<String, dynamic> json) {
    availableMarkets = json['available_markets'].cast<String>();
    type = json['type'];
    albumType = json['album_type'];
    href = json['href'];
    id = json['id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    name = json['name'];
    releaseDate = json['release_date'];
    releaseDatePrecision = json['release_date_precision'];
    uri = json['uri'];
    if (json['artists'] != null) {
      artists = <Artists>[];
      json['artists'].forEach((v) {
        artists!.add(new Artists.fromJson(v));
      });
    }
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    totalTracks = json['total_tracks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available_markets'] = this.availableMarkets;
    data['type'] = this.type;
    data['album_type'] = this.albumType;
    data['href'] = this.href;
    data['id'] = this.id;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['release_date'] = this.releaseDate;
    data['release_date_precision'] = this.releaseDatePrecision;
    data['uri'] = this.uri;
    if (this.artists != null) {
      data['artists'] = this.artists!.map((v) => v.toJson()).toList();
    }
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    data['total_tracks'] = this.totalTracks;
    return data;
  }
}

class Artists {
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  String? name;
  String? type;
  String? uri;

  Artists(
      {this.externalUrls, this.href, this.id, this.name, this.type, this.uri});

  Artists.fromJson(Map<String, dynamic> json) {
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    name = json['name'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['uri'] = this.uri;
    return data;
  }
}

class ExternalIds {
  String? isrc;

  ExternalIds({this.isrc});

  ExternalIds.fromJson(Map<String, dynamic> json) {
    isrc = json['isrc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isrc'] = this.isrc;
    return data;
  }
}
