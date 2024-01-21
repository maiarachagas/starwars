import 'package:app_teste_unitario/app/models/bing_model.dart';
import 'package:app_teste_unitario/app/models/films_model.dart';
import 'package:app_teste_unitario/app/models/planets_model.dart';
import 'package:app_teste_unitario/app/models/species_model.dart';

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
