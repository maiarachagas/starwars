import 'dart:convert';

import 'films_model.dart';
import 'personages_model.dart';

class Vehicles {
  int? count;
  String? next;
  String? current;
  String? previous;
  List<Vehicle>? vehicle;

  Vehicles({
    this.count,
    this.next,
    this.current,
    this.previous,
    this.vehicle,
  });

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'next': next,
      'current': current,
      'previous': previous,
      'vehicle': vehicle?.map((x) => x.toMap()).toList(),
    };
  }

  factory Vehicles.fromMap(Map<String, dynamic> map, String url) {
    return Vehicles(
      count: map['count']?.toInt(),
      next: map['next'],
      current: url,
      previous: map['previous'],
      vehicle: map['vehicle'] != null
          ? List<Vehicle>.from(map['vehicle']?.map((x) => Vehicle.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicles.fromJson(String source, String url) =>
      Vehicles.fromMap(json.decode(source), url);

  @override
  String toString() {
    return 'Vehicles(count: $count, next: $next, current: $current, previous: $previous, vehicle: $vehicle)';
  }
}

class Vehicle {
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
  String? vehicleClass;
  List<String>? pilots;
  List<String>? films;
  String? created;
  String? edited;
  String? url;
  String? thumbnailUrl;

  List<Film> filmsList = [];
  List<Personage> personageList = [];

  Vehicle({
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
    this.vehicleClass,
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
      'vehicleClass': vehicleClass,
      'pilots': pilots,
      'films': films,
      'created': created,
      'edited': edited,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      name: map['name'],
      model: map['model'],
      manufacturer: map['manufacturer'],
      costInCredits: map['cost_in_credits'],
      length: map['length'],
      maxAtmospheringSpeed: map['max_atmosphering_speed'],
      crew: map['crew'],
      passengers: map['passengers'],
      cargoCapacity: map['cargo_capacity'],
      consumables: map['consumables'],
      vehicleClass: map['vehicle_class'],
      pilots: List<String>.from(map['pilots']),
      films: List<String>.from(map['films']),
      created: map['created'],
      edited: map['edited'],
      url: map['url'],
      thumbnailUrl: map['thumbnailUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle.fromJson(String source) =>
      Vehicle.fromMap(json.decode(source));

  void addFilm(Film film) {
    filmsList.add(film);
  }

  void addPeople(Personage personage) {
    personageList.add(personage);
  }

  @override
  String toString() {
    return 'Vehicle(name: $name, model: $model, manufacturer: $manufacturer, costInCredits: $costInCredits, length: $length, maxAtmospheringSpeed: $maxAtmospheringSpeed, crew: $crew, passengers: $passengers, cargoCapacity: $cargoCapacity, consumables: $consumables, vehicleClass: $vehicleClass, pilots: $pilots, films: $films, created: $created, edited: $edited, url: $url, thumbnailUrl: $thumbnailUrl)';
  }
}
