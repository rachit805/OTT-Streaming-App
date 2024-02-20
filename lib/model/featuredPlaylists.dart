class FeaturedPlaylists {
  String? message;
  Playlists? playlists;

  FeaturedPlaylists({this.message, this.playlists});

  FeaturedPlaylists.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    playlists = json['playlists'] != null
        ? new Playlists.fromJson(json['playlists'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.playlists != null) {
      data['playlists'] = this.playlists!.toJson();
    }
    return data;
  }
}

class Playlists {
  String? href;
  int? limit;
  String? next;
  int? offset;
  Null? previous;
  int? total;
  List<Items>? items;

  Playlists(
      {this.href,
      this.limit,
      this.next,
      this.offset,
      this.previous,
      this.total,
      this.items});

  Playlists.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    limit = json['limit'];
    next = json['next'];
    offset = json['offset'];
    previous = json['previous'];
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
    data['href'] = this.href;
    data['limit'] = this.limit;
    data['next'] = this.next;
    data['offset'] = this.offset;
    data['previous'] = this.previous;
    data['total'] = this.total;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  bool? collaborative;
  String? description;
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  List<Images>? images;
  String? name;
  Owner? owner;
  bool? public;
  String? snapshotId;
  Tracks? tracks;
  String? type;
  String? uri;
  String? primaryColor;

  Items(
      {this.collaborative,
      this.description,
      this.externalUrls,
      this.href,
      this.id,
      this.images,
      this.name,
      this.owner,
      this.public,
      this.snapshotId,
      this.tracks,
      this.type,
      this.uri,
      this.primaryColor});

  Items.fromJson(Map<String, dynamic> json) {
    collaborative = json['collaborative'];
    description = json['description'];
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    name = json['name'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    public = json['public'];
    snapshotId = json['snapshot_id'];
    tracks =
        json['tracks'] != null ? new Tracks.fromJson(json['tracks']) : null;
    type = json['type'];
    uri = json['uri'];
    primaryColor = json['primary_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collaborative'] = this.collaborative;
    data['description'] = this.description;
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['public'] = this.public;
    data['snapshot_id'] = this.snapshotId;
    if (this.tracks != null) {
      data['tracks'] = this.tracks!.toJson();
    }
    data['type'] = this.type;
    data['uri'] = this.uri;
    data['primary_color'] = this.primaryColor;
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

class Images {
  String? url;
  Null? height;
  Null? width;

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
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  String? type;
  String? uri;
  String? displayName;

  Owner(
      {this.externalUrls,
      this.href,
      this.id,
      this.type,
      this.uri,
      this.displayName});

  Owner.fromJson(Map<String, dynamic> json) {
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    type = json['type'];
    uri = json['uri'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    data['type'] = this.type;
    data['uri'] = this.uri;
    data['display_name'] = this.displayName;
    return data;
  }
}

class Tracks {
  String? href;
  int? total;

  Tracks({this.href, this.total});

  Tracks.fromJson(Map<String, dynamic> json) {
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
