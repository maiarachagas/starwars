import 'package:app_teste_unitario/app/models/bing_model.dart';
import 'package:app_teste_unitario/app/models/category_model.dart';
import 'package:app_teste_unitario/app/models/films_model.dart';
import 'package:app_teste_unitario/app/models/personages_model.dart';
import 'package:app_teste_unitario/app/models/planets_model.dart';
import 'package:app_teste_unitario/app/models/species_model.dart';
import 'package:app_teste_unitario/app/models/starships_model.dart';
import 'package:app_teste_unitario/app/models/vehicles_model.dart';

List<InfoImage> get infoImage => [
      InfoImage(
          thumbnailUrl:
              'https://tse4.mm.bing.net/th?id=OIP.FKsBijrcaeAWzHQbO81nGQHaLI&pid=Api'),
      InfoImage(
          thumbnailUrl:
              'https://tse4.mm.bing.net/th?id=OIP.YhUlntbH98C7Vi-uKF0xlwHaFj&pid=Api'),
      InfoImage(
          thumbnailUrl:
              'https://tse1.mm.bing.net/th?id=OIP.w25ZoCwIb9HMq9xZSNUWmgHaH4&pid=Api')
    ];

List<Personage> get personage => [
      Personage(name: 'Luke Skywalker'),
      Personage(name: 'Darth Vader'),
      Personage(name: 'Leia Organa'),
    ];

Personages get personages =>
    Personages(count: 80, next: '2', previous: '0', personage: personage);

List<Film> get film => [
      Film(title: 'A New Hope'),
      Film(title: 'Return of the Jedi'),
      Film(title: 'The Phantom Menace'),
    ];

List<Planet> get planet => [
      Planet(name: 'Tatooine'),
      Planet(name: 'Alderaan'),
      Planet(name: 'Hoth'),
    ];

Planets get planets =>
    Planets(count: 80, next: '2', previous: '0', planet: planet);

List<Specie> get specie => [
      Specie(name: 'Human'),
      Specie(name: 'Droid'),
      Specie(name: 'Wookie'),
    ];

Species get species =>
    Species(count: 80, next: '2', previous: '0', specie: specie);

List<Vehicle> get vehicle => [
      Vehicle(name: 'Sand Crawler'),
      Vehicle(name: 'T-16 skyhopper'),
      Vehicle(name: 'X-34 landspeeder'),
    ];

Vehicles get vehicles =>
    Vehicles(count: 80, next: '2', previous: '0', vehicle: vehicle);

List<Starship> get starship => [
      Starship(name: 'Death Star'),
      Starship(name: 'Millennium Falcon'),
      Starship(name: 'Star Destroyer'),
    ];

Starships get starships =>
    Starships(count: 80, next: '2', previous: '0', starship: starship);

List<Detail> get details => [
      Detail(name: 'Luke Skywalker'),
      Detail(name: 'Darth Vader'),
      Detail(name: 'Leia Organa'),
    ];

Category get category =>
    Category(count: 80, next: '2', previous: '0', detail: details);
