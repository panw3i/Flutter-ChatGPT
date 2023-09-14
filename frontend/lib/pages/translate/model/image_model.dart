/// url : "https://cdn.catboys.com/images/image_37.jpg"
/// artist : "unknown"
/// artist_url : "none"
/// source_url : "none"
/// error : "none"

class ImageModel {
  ImageModel({
      this.url, 
      this.artist, 
      this.artistUrl, 
      this.sourceUrl, 
      this.error,});

  ImageModel.fromJson(dynamic json) {
    url = json['url'];
    artist = json['artist'];
    artistUrl = json['artist_url'];
    sourceUrl = json['source_url'];
    error = json['error'];
  }
  String? url;
  String? artist;
  String? artistUrl;
  String? sourceUrl;
  String? error;
ImageModel copyWith({  String? url,
  String? artist,
  String? artistUrl,
  String? sourceUrl,
  String? error,
}) => ImageModel(  url: url ?? this.url,
  artist: artist ?? this.artist,
  artistUrl: artistUrl ?? this.artistUrl,
  sourceUrl: sourceUrl ?? this.sourceUrl,
  error: error ?? this.error,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['artist'] = artist;
    map['artist_url'] = artistUrl;
    map['source_url'] = sourceUrl;
    map['error'] = error;
    return map;
  }

}