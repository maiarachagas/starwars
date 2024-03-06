import 'dart:convert';

import 'package:project_starwars/app/models/films_model.dart';
import 'package:project_starwars/app/models/planets_model.dart';
import 'package:project_starwars/app/models/species_model.dart';
import 'package:project_starwars/app/models/starships_model.dart';
import 'package:project_starwars/app/models/vehicles_model.dart';

class Personages {
  int? count;
  String? next;
  String? current;
  String? previous;
  List<Personage>? personage;

  Personages(
      {this.count, this.next, this.previous, this.current, this.personage});

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'personages': personage?.map((x) => x.toMap()).toList(),
    };
  }

  factory Personages.fromMap(Map<String, dynamic> map, String url) {
    return Personages(
      count: map['count']?.toInt(),
      current: url,
      next: map['next'],
      previous: map['previous'] ?? 'page=0',
      personage: map['results'] != null
          ? List<Personage>.from(
              map['results']?.map((x) => Personage.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Personages.fromJson(String source, String url) =>
      Personages.fromMap(json.decode(source), url);

  @override
  String toString() {
    return 'AllPersonages(count: $count, next: $next, previous: $previous, personages: $personage)';
  }
}

class Personage {
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

  List<Film> filmsList = [];
  List<Specie> speciesList = [];
  List<Starship> starshipsList = [];
  List<Vehicle> vehiclesList = [];
  Planet planet = Planet();

  Personage({
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

  factory Personage.fromMap(Map<String, dynamic> map) {
    return Personage(
      name: map['name'],
      birthYear: map['birth_year'],
      eyeColor: map['eye_color'],
      gender: map['gender'],
      hairColor: map['hair_color'],
      height: map['height'],
      mass: map['mass'],
      skinColor: map['skin_color'],
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

  factory Personage.fromJson(String source) =>
      Personage.fromMap(json.decode(source));

  void addFilm(Film film) {
    filmsList.add(film);
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

  void addPlanet(Planet home) {
    planet = home;
  }

  @override
  String toString() {
    return 'Personages(name: $name, birthYear: $birthYear, eyeColor: $eyeColor, gender: $gender, hairColor: $hairColor, height: $height, mass: $mass, skinColor: $skinColor, homeworld: $homeworld, films: $films, species: $species, starships: $starships, vehicles: $vehicles, url: $url, created: $created, edited: $edited, image: $thumbnailUrl)';
  }
}
