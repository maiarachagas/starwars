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

Film get detailsFilm => Film(
    title: 'Return of the Jedi',
    thumbnailUrl:
        'data:image/jpeg;base64,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',
    url: 'https://www.google.com.br');
