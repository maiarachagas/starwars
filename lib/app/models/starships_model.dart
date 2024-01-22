import 'dart:convert';

class Starships {
  int? count;
  String? next;
  String? current;
  String? previous;
  List<Starship>? starship;

  Starships({
    this.count,
    this.next,
    this.current,
    this.previous,
    this.starship,
  });

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'next': next,
      'current': current,
      'previous': previous,
      'starship': starship?.map((x) => x.toMap()).toList(),
    };
  }

  factory Starships.fromMap(Map<String, dynamic> map, String url) {
    return Starships(
      count: map['count']?.toInt(),
      next: map['next'],
      current: url,
      previous: map['previous'],
      starship: map['starship'] != null
          ? List<Starship>.from(
              map['starship']?.map((x) => Starship.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Starships.fromJson(String source, String url) =>
      Starships.fromMap(json.decode(source), url);

  @override
  String toString() {
    return 'Starships(count: $count, next: $next, current: $current, previous: $previous, starship: $starship)';
  }
}

class Starship {
  String? name;
  String? model;
  String? manufacturer;
  String? costInCredits;
  String? length;
  String? maxAtmospheringSpeed;
  String? crew;
  String? passengers;
  String? cargoCapacity;
  String? consumables;
  String? hyperdriveRating;
  String? mGLT;
  String? starshipClass;
  List<String>? pilots;
  List<String>? films;
  String? created;
  String? edited;
  String? url;
  String? thumbnailUrl;

  Starship({
    this.name,
    this.model,
    this.manufacturer,
    this.costInCredits,
    this.length,
    this.maxAtmospheringSpeed,
    this.crew,
    this.passengers,
    this.cargoCapacity,
    this.consumables,
    this.hyperdriveRating,
    this.mGLT,
    this.starshipClass,
    this.pilots,
    this.films,
    this.created,
    this.edited,
    this.url,
    this.thumbnailUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'model': model,
      'manufacturer': manufacturer,
      'costInCredits': costInCredits,
      'length': length,
      'maxAtmospheringSpeed': maxAtmospheringSpeed,
      'crew': crew,
      'passengers': passengers,
      'cargoCapacity': cargoCapacity,
      'consumables': consumables,
      'hyperdriveRating': hyperdriveRating,
      'mGLT': mGLT,
      'starshipClass': starshipClass,
      'pilots': pilots,
      'films': films,
      'created': created,
      'edited': edited,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory Starship.fromMap(Map<String, dynamic> map) {
    return Starship(
      name: map['name'],
      model: map['model'],
      manufacturer: map['manufacturer'],
      costInCredits: map['costInCredits'],
      length: map['length'],
      maxAtmospheringSpeed: map['maxAtmospheringSpeed'],
      crew: map['crew'],
      passengers: map['passengers'],
      cargoCapacity: map['cargoCapacity'],
      consumables: map['consumables'],
      hyperdriveRating: map['hyperdriveRating'],
      mGLT: map['mGLT'],
      starshipClass: map['starshipClass'],
      pilots: List<String>.from(map['pilots']),
      films: List<String>.from(map['films']),
      created: map['created'],
      edited: map['edited'],
      url: map['url'],
      thumbnailUrl: map['thumbnailUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Starship.fromJson(String source) =>
      Starship.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Starship(name: $name, model: $model, manufacturer: $manufacturer, costInCredits: $costInCredits, length: $length, maxAtmospheringSpeed: $maxAtmospheringSpeed, crew: $crew, passengers: $passengers, cargoCapacity: $cargoCapacity, consumables: $consumables, hyperdriveRating: $hyperdriveRating, mGLT: $mGLT, starshipClass: $starshipClass, pilots: $pilots, films: $films, created: $created, edited: $edited, url: $url, thumbnailUrl: $thumbnailUrl)';
  }
}
