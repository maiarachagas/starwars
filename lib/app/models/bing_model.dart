import 'dart:convert';

class InfoBingImage {
  List<InfoImage>? value;

  InfoBingImage({this.value});

  Map<String, dynamic> toMap() {
    return {
      'value': value?.map((x) => x.toMap()).toList(),
    };
  }

  factory InfoBingImage.fromMap(Map<String, dynamic> map) {
    return InfoBingImage(
      value: map['value'] != null
          ? List<InfoImage>.from(map['value']?.map((x) => InfoImage.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InfoBingImage.fromJson(String source) =>
      InfoBingImage.fromMap(json.decode(source));
}

class InfoImage {
  String? webSearchUrl;
  String? name;
  String? thumbnailUrl;
  String? datePublished;
  bool? isFamilyFriendly;
  String? contentUrl;
  String? hostPageUrl;
  String? contentSize;
  String? encodingFormat;
  String? hostPageDisplayUrl;
  String? hostPageFavIconUrl;
  String? hostPageDiscoveredDate;
  String? imageInsightsToken;
  String? imageId;
  String? accentColor;

  InfoImage({
    this.webSearchUrl,
    this.name,
    this.thumbnailUrl,
    this.datePublished,
    this.isFamilyFriendly,
    this.contentUrl,
    this.hostPageUrl,
    this.contentSize,
    this.encodingFormat,
    this.hostPageDisplayUrl,
    this.hostPageFavIconUrl,
    this.hostPageDiscoveredDate,
    this.imageInsightsToken,
    this.imageId,
    this.accentColor,
  });

  Map<String, dynamic> toMap() {
    return {
      'webSearchUrl': webSearchUrl,
      'name': name,
      'thumbnailUrl': thumbnailUrl,
      'datePublished': datePublished,
      'isFamilyFriendly': isFamilyFriendly,
      'contentUrl': contentUrl,
      'hostPageUrl': hostPageUrl,
      'contentSize': contentSize,
      'encodingFormat': encodingFormat,
      'hostPageDisplayUrl': hostPageDisplayUrl,
      'hostPageFavIconUrl': hostPageFavIconUrl,
      'hostPageDiscoveredDate': hostPageDiscoveredDate,
      'imageInsightsToken': imageInsightsToken,
      'imageId': imageId,
      'accentColor': accentColor,
    };
  }

  factory InfoImage.fromMap(Map<String, dynamic> map) {
    return InfoImage(
      webSearchUrl: map['webSearchUrl'],
      name: map['name'],
      thumbnailUrl: map['thumbnailUrl'],
      datePublished: map['datePublished'],
      isFamilyFriendly: map['isFamilyFriendly'],
      contentUrl: map['contentUrl'],
      hostPageUrl: map['hostPageUrl'],
      contentSize: map['contentSize'],
      encodingFormat: map['encodingFormat'],
      hostPageDisplayUrl: map['hostPageDisplayUrl'],
      hostPageFavIconUrl: map['hostPageFavIconUrl'],
      hostPageDiscoveredDate: map['hostPageDiscoveredDate'],
      imageInsightsToken: map['imageInsightsToken'],
      imageId: map['imageId'],
      accentColor: map['accentColor'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InfoImage.fromJson(String source) =>
      InfoImage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InfoImage(webSearchUrl: $webSearchUrl, name: $name, thumbnailUrl: $thumbnailUrl, datePublished: $datePublished, isFamilyFriendly: $isFamilyFriendly, contentUrl: $contentUrl, hostPageUrl: $hostPageUrl, contentSize: $contentSize, encodingFormat: $encodingFormat, hostPageDisplayUrl: $hostPageDisplayUrl, hostPageFavIconUrl: $hostPageFavIconUrl, hostPageDiscoveredDate: $hostPageDiscoveredDate, imageInsightsToken: $imageInsightsToken, imageId: $imageId, accentColor: $accentColor)';
  }
}
