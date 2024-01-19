import 'dart:convert';

class AllPersonages {
  int? count;
  String? next;
  String? current;
  String? previous;
  List<Personages>? personages;

  AllPersonages(
      {this.count, this.next, this.previous, this.current, this.personages});

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'personages': personages?.map((x) => x.toMap()).toList(),
    };
  }

  factory AllPersonages.fromMap(Map<String, dynamic> map, String url) {
    return AllPersonages(
      count: map['count']?.toInt(),
      current: url,
      next: map['next'],
      previous: map['previous'] ?? 'page=0',
      personages: map['results'] != null
          ? List<Personages>.from(
              map['results']?.map((x) => Personages.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AllPersonages.fromJson(String source, String url) =>
      AllPersonages.fromMap(json.decode(source), url);

  @override
  String toString() {
    return 'AllPersonages(count: $count, next: $next, previous: $previous, personages: $personages)';
  }
}

class Personages {
  String? name;
  String? birthYear;
  String? eyeColor;
  String? gender;
  String? hairColor;
  String? height;
  String? mass;
  String? skinColor;
  String? homeworld;
  List<String>? films;
  List<String>? species;
  List<String>? starships;
  List<String>? vehicles;
  String? url;
  String? created;
  String? edited;
  String? thumbnailUrl;

  Personages({
    this.name,
    this.birthYear,
    this.eyeColor,
    this.gender,
    this.hairColor,
    this.height,
    this.mass,
    this.skinColor,
    this.homeworld,
    this.films,
    this.species,
    this.starships,
    this.vehicles,
    this.url,
    this.created,
    this.edited,
    this.thumbnailUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'birthYear': birthYear,
      'eyeColor': eyeColor,
      'gender': gender,
      'hairColor': hairColor,
      'height': height,
      'mass': mass,
      'skinColor': skinColor,
      'homeworld': homeworld,
      'films': films,
      'species': species,
      'starships': starships,
      'vehicles': vehicles,
      'url': url,
      'created': created,
      'edited': edited,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory Personages.fromMap(Map<String, dynamic> map) {
    return Personages(
      name: map['name'],
      birthYear: map['birthYear'],
      eyeColor: map['eyeColor'],
      gender: map['gender'],
      hairColor: map['hairColor'],
      height: map['height'],
      mass: map['mass'],
      skinColor: map['skinColor'],
      homeworld: map['homeworld'],
      films: List<String>.from(map['films']),
      species: List<String>.from(map['species']),
      starships: List<String>.from(map['starships']),
      vehicles: List<String>.from(map['vehicles']),
      url: map['url'],
      created: map['created'],
      edited: map['edited'],
      thumbnailUrl: map['thumbnailUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Personages.fromJson(String source) =>
      Personages.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Personages(name: $name, birthYear: $birthYear, eyeColor: $eyeColor, gender: $gender, hairColor: $hairColor, height: $height, mass: $mass, skinColor: $skinColor, homeworld: $homeworld, films: $films, species: $species, starships: $starships, vehicles: $vehicles, url: $url, created: $created, edited: $edited, image: $thumbnailUrl)';
  }
}
