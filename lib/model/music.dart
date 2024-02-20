class Music {
  String? idAlbum;
  String? idArtist;
  String? idLabel;
  String? strAlbum;
  String? strAlbumStripped;
  String? strArtist;
  String? strArtistStripped;
  String? intYearReleased;
  String? strStyle;
  String? strGenre;
  String? strLabel;
  String? strReleaseFormat;
  String? intSales;
  String? strAlbumThumb;
  // Null? strAlbumThumbHQ;
  String? strAlbumThumbBack;
  String? strAlbumCDart;
  String? strAlbumSpine;
  String? strAlbum3DCase;
  String? strAlbum3DFlat;
  String? strAlbum3DFace;
  String? strAlbum3DThumb;
  String? strDescriptionEN;

  String? intLoved;
  String? intScore;
  String? intScoreVotes;
  String? strReview;
  String? strMood;
  String? strTheme;
  String? strSpeed;
  // Null? strLocation;
  String? strMusicBrainzID;
  String? strMusicBrainzArtistID;
  String? strAllMusicID;
  String? strBBCReviewID;
  String? strRateYourMusicID;
  String? strDiscogsID;
  String? strWikidataID;
  String? strWikipediaID;
  String? strGeniusID;

  Music({
    this.idAlbum,
    this.idArtist,
    this.idLabel,
    this.strAlbum,
    this.strAlbumStripped,
    this.strArtist,
    this.strArtistStripped,
    this.intYearReleased,
    this.strStyle,
    this.strGenre,
    this.strLabel,
    this.strReleaseFormat,
    this.intSales,
    this.strAlbumThumb,
    // this.strAlbumThumbHQ,
    this.strAlbumThumbBack,
    this.strAlbumCDart,
    this.strAlbumSpine,
    this.strAlbum3DCase,
    this.strAlbum3DFlat,
    this.strAlbum3DFace,
    this.strAlbum3DThumb,
    this.strDescriptionEN,
    // this.strDescriptionDE,
    // this.strDescriptionFR,
    // this.strDescriptionCN,
    // this.strDescriptionIT,
    // this.strDescriptionJP,
    // this.strDescriptionRU,
    // this.strDescriptionES,
    // this.strDescriptionPT,
    // this.strDescriptionSE,
    // this.strDescriptionNL,
    // this.strDescriptionHU,
    // this.strDescriptionNO,
    // this.strDescriptionIL,
    // this.strDescriptionPL,
    this.intLoved,
    this.intScore,
    this.intScoreVotes,
    this.strReview,
    this.strMood,
    this.strTheme,
    this.strSpeed,
    // this.strLocation,
    this.strMusicBrainzID,
    this.strMusicBrainzArtistID,
    this.strAllMusicID,
    this.strBBCReviewID,
    this.strRateYourMusicID,
    this.strDiscogsID,
    this.strWikidataID,
    this.strWikipediaID,
    this.strGeniusID,
    // this.strLyricWikiID,
    // this.strMusicMozID,
    // this.strItunesID,
    // this.strAmazonID,
    // this.strLocked,
    // this.strDescription
  });

  Music.fromJson(Map<String, dynamic> json) {
    idAlbum = json['idAlbum'];
    idArtist = json['idArtist'];
    idLabel = json['idLabel'];
    strAlbum = json['strAlbum'];
    strAlbumStripped = json['strAlbumStripped'];
    strArtist = json['strArtist'];
    strArtistStripped = json['strArtistStripped'];
    intYearReleased = json['intYearReleased'];
    strStyle = json['strStyle'];
    strGenre = json['strGenre'];
    strLabel = json['strLabel'];
    strReleaseFormat = json['strReleaseFormat'];
    intSales = json['intSales'];
    strAlbumThumb = json['strAlbumThumb'];
    // strAlbumThumbHQ = json['strAlbumThumbHQ'];
    strAlbumThumbBack = json['strAlbumThumbBack'];
    strAlbumCDart = json['strAlbumCDart'];
    strAlbumSpine = json['strAlbumSpine'];
    strAlbum3DCase = json['strAlbum3DCase'];
    strAlbum3DFlat = json['strAlbum3DFlat'];
    strAlbum3DFace = json['strAlbum3DFace'];
    strAlbum3DThumb = json['strAlbum3DThumb'];
    strDescriptionEN = json['strDescriptionEN'];
    // strDescriptionDE = json['strDescriptionDE'];
    // strDescriptionFR = json['strDescriptionFR'];
    // strDescriptionCN = json['strDescriptionCN'];
    // strDescriptionIT = json['strDescriptionIT'];
    // strDescriptionJP = json['strDescriptionJP'];
    // strDescriptionRU = json['strDescriptionRU'];
    // strDescriptionPT = json['strDescriptionPT'];
    // strDescriptionSE = json['strDescriptionSE'];
    // strDescriptionNL = json['strDescriptionNL'];
    // strDescriptionHU = json['strDescriptionHU'];
    // strDescriptionNO = json['strDescriptionNO'];
    // strDescriptionIL = json['strDescriptionIL'];
    // strDescriptionPL = json['strDescriptionPL'];
    intLoved = json['intLoved'];
    intScore = json['intScore'];
    intScoreVotes = json['intScoreVotes'];
    strReview = json['strReview'];
    strMood = json['strMood'];
    strTheme = json['strTheme'];
    strSpeed = json['strSpeed'];
    // strLocation = json['strLocation'];
    strMusicBrainzID = json['strMusicBrainzID'];
    strMusicBrainzArtistID = json['strMusicBrainzArtistID'];
    strAllMusicID = json['strAllMusicID'];
    strBBCReviewID = json['strBBCReviewID'];
    strRateYourMusicID = json['strRateYourMusicID'];
    strDiscogsID = json['strDiscogsID'];
    strWikidataID = json['strWikidataID'];
    strWikipediaID = json['strWikipediaID'];
    strGeniusID = json['strGeniusID'];
    // strLyricWikiID = json['strLyricWikiID'];
    // strMusicMozID = json['strMusicMozID'];
    // strItunesID = json['strItunesID'];
    // strAmazonID = json['strAmazonID'];
    // strLocked = json['strLocked'];
    // strDescription = json['strDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idAlbum'] = this.idAlbum;
    data['idArtist'] = this.idArtist;
    data['idLabel'] = this.idLabel;
    data['strAlbum'] = this.strAlbum;
    data['strAlbumStripped'] = this.strAlbumStripped;
    data['strArtist'] = this.strArtist;
    data['strArtistStripped'] = this.strArtistStripped;
    data['intYearReleased'] = this.intYearReleased;
    data['strStyle'] = this.strStyle;
    data['strGenre'] = this.strGenre;
    data['strLabel'] = this.strLabel;
    data['strReleaseFormat'] = this.strReleaseFormat;
    data['intSales'] = this.intSales;
    data['strAlbumThumb'] = this.strAlbumThumb;
    // data['strAlbumThumbHQ'] = this.strAlbumThumbHQ;
    data['strAlbumThumbBack'] = this.strAlbumThumbBack;
    data['strAlbumCDart'] = this.strAlbumCDart;
    data['strAlbumSpine'] = this.strAlbumSpine;
    data['strAlbum3DCase'] = this.strAlbum3DCase;
    data['strAlbum3DFlat'] = this.strAlbum3DFlat;
    data['strAlbum3DFace'] = this.strAlbum3DFace;
    data['strAlbum3DThumb'] = this.strAlbum3DThumb;
    data['strDescriptionEN'] = this.strDescriptionEN;

    data['intLoved'] = this.intLoved;
    data['intScore'] = this.intScore;
    data['intScoreVotes'] = this.intScoreVotes;
    data['strReview'] = this.strReview;
    data['strMood'] = this.strMood;
    data['strTheme'] = this.strTheme;
    data['strSpeed'] = this.strSpeed;
    // data['strLocation'] = this.strLocation;
    data['strMusicBrainzID'] = this.strMusicBrainzID;
    data['strMusicBrainzArtistID'] = this.strMusicBrainzArtistID;
    data['strAllMusicID'] = this.strAllMusicID;
    data['strBBCReviewID'] = this.strBBCReviewID;
    data['strRateYourMusicID'] = this.strRateYourMusicID;
    data['strDiscogsID'] = this.strDiscogsID;
    data['strWikidataID'] = this.strWikidataID;
    data['strWikipediaID'] = this.strWikipediaID;
    data['strGeniusID'] = this.strGeniusID;
    // data['strLyricWikiID'] = this.strLyricWikiID;
    // data['strMusicMozID'] = this.strMusicMozID;
    // data['strItunesID'] = this.strItunesID;
    // data['strAmazonID'] = this.strAmazonID;
    // data['strLocked'] = this.strLocked;
    // data['strDescription'] = this.strDescription;
    return data;
  }
}
