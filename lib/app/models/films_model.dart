import 'dart:convert';

import 'index.dart';

class Films {
  int? count;
  String? next;
  String? current;
  String? previous;
  List<Film>? film;

  Films({
    this.count,
    this.next,
    this.current,
    this.previous,
    this.film,
  });

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'next': next,
      'current': current,
      'previous': previous,
      'film': film?.map((x) => x.toMap()).toList(),
    };
  }

  factory Films.fromMap(Map<String, dynamic> map, String url) {
    return Films(
      count: map['count']?.toInt(),
      next: map['next'] ?? '',
      current: map['current'] ?? '',
      previous: map['previous'] ?? '',
      film: map['film'] != null
          ? List<Film>.from(map['film']?.map((x) => Film.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Films.fromJson(String source, String url) =>
      Films.fromMap(json.decode(source), url);

  @override
  String toString() {
    return 'Films(count: $count, next: $next, current: $current, previous: $previous, film: $film)';
  }
}

class Film {
  String? title;
  int? episodeId;
  String? openingCrawl;
  String? director;
  String? producer;
  String? releaseDate;
  List<String>? characters;
  List<String>? planets;
  List<String>? starships;
  List<String>? vehicles;
  List<String>? species;
  String? created;
  String? edited;
  String? url;
  String? thumbnailUrl;

  List<Personage> personageList = [];
  List<Specie> speciesList = [];
  List<Starship> starshipsList = [];
  List<Vehicle> vehiclesList = [];
  List<Planet> planetList = [];

  Film({
    this.title,
    this.episodeId,
    this.openingCrawl,
    this.director,
    this.producer,
    this.releaseDate,
    this.characters,
    this.planets,
    this.starships,
    this.vehicles,
    this.species,
    this.created,
    this.edited,
    this.url,
    this.thumbnailUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'episodeId': episodeId,
      'openingCrawl': openingCrawl,
      'director': director,
      'producer': producer,
      'releaseDate': releaseDate,
      'characters': characters,
      'planets': planets,
      'starships': starships,
      'vehicles': vehicles,
      'species': species,
      'created': created,
      'edited': edited,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory Film.fromMap(Map<String, dynamic> map) {
    return Film(
      title: map['title'],
      episodeId: map['episode_id']?.toInt(),
      openingCrawl: map['opening_crawl'].toString().replaceAll('\r\n', ' '),
      director: map['director'],
      producer: map['producer'],
      releaseDate: map['release_date'],
      characters: List<String>.from(map['characters']),
      planets: List<String>.from(map['planets']),
      starships: List<String>.from(map['starships']),
      vehicles: List<String>.from(map['vehicles']),
      species: List<String>.from(map['species']),
      created: map['created'],
      edited: map['edited'],
      url: map['url'],
      thumbnailUrl: map['thumbnailUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Film.fromJson(String source) => Film.fromMap(json.decode(source));

  void addPeople(Personage personage) {
    personageList.add(personage);
  }

  void addSpecie(Specie specie) {
    speciesList.add(specie);
  }

  void addStarship(Starship starship) {
    starshipsList.add(starship);
  }

  void addVehicle(Vehicle vehicle) {
    vehiclesList.add(vehicle);
  }

  void addPlanet(Planet planet) {
    planetList.add(planet);
  }

  @override
  String toString() {
    return 'Film(title: $title, episodeId: $episodeId, openingCrawl: $openingCrawl, director: $director, producer: $producer, releaseDate: $releaseDate, characters: $characters, planets: $planets, starships: $starships, vehicles: $vehicles, species: $species, created: $created, edited: $edited, url: $url)';
  }
}
