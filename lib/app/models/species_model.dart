import 'dart:convert';

import 'index.dart';

class Species {
  int? count;
  String? next;
  String? current;
  String? previous;
  List<Specie>? specie;

  Species({
    this.count,
    this.next,
    this.current,
    this.previous,
    this.specie,
  });

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'next': next,
      'current': current,
      'previous': previous,
      'results': specie?.map((x) => x.toMap()).toList(),
    };
  }

  factory Species.fromMap(Map<String, dynamic> map, String url) {
    return Species(
      count: map['count']?.toInt(),
      next: map['next'],
      current: url,
      previous: map['previous'],
      specie: map['results'] != null
          ? List<Specie>.from(map['results']?.map((x) => Specie.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Species.fromJson(String source, String url) =>
      Species.fromMap(json.decode(source), url);

  @override
  String toString() {
    return 'Species(count: $count, next: $next, current: $current, previous: $previous, results: $specie)';
  }
}

class Specie {
  String? name;
  String? classification;
  String? designation;
  String? averageHeight;
  String? skinColors;
  String? hairColors;
  String? eyeColors;
  String? averageLifespan;
  String? homeworld;
  String? language;
  List<String>? people;
  List<String>? films;
  String? created;
  String? edited;
  String? url;
  String? thumbnailUrl;

  List<Film> filmsList = [];
  List<Personage> personageList = [];
  Planet planet = Planet();

  Specie({
    this.name,
    this.classification,
    this.designation,
    this.averageHeight,
    this.skinColors,
    this.hairColors,
    this.eyeColors,
    this.averageLifespan,
    this.homeworld,
    this.language,
    this.people,
    this.films,
    this.created,
    this.edited,
    this.url,
    this.thumbnailUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'classification': classification,
      'designation': designation,
      'averageHeight': averageHeight,
      'skinColors': skinColors,
      'hairColors': hairColors,
      'eyeColors': eyeColors,
      'averageLifespan': averageLifespan,
      'homeworld': homeworld,
      'language': language,
      'people': people,
      'films': films,
      'created': created,
      'edited': edited,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory Specie.fromMap(Map<String, dynamic> map) {
    return Specie(
      name: map['name'],
      classification: map['classification'],
      designation: map['designation'],
      averageHeight: map['average_height'],
      skinColors: map['skin_colors'],
      hairColors: map['hair_colors'],
      eyeColors: map['eye_colors'],
      averageLifespan: map['average_lifespan'],
      homeworld: map['homeworld'],
      language: map['language'],
      people: List<String>.from(map['people']),
      films: List<String>.from(map['films']),
      created: map['created'],
      edited: map['edited'],
      url: map['url'],
      thumbnailUrl: map['thumbnailUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Specie.fromJson(String source) => Specie.fromMap(json.decode(source));

  void addFilm(Film film) {
    filmsList.add(film);
  }

  void addPeople(Personage personage) {
    personageList.add(personage);
  }

  void addPlanet(Planet home) {
    planet = home;
  }

  @override
  String toString() {
    return 'Specie(name: $name, classification: $classification, designation: $designation, averageHeight: $averageHeight, skinColors: $skinColors, hairColors: $hairColors, eyeColors: $eyeColors, averageLifespan: $averageLifespan, homeworld: $homeworld, language: $language, people: $people, films: $films, created: $created, edited: $edited, url: $url, thumbnailUrl: $thumbnailUrl)';
  }
}
