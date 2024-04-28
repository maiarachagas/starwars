import 'package:project_starwars/app/services/swapi_rest/index.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'mock_data.dart';

class MockClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late http.Client httpClient;
  late FilmsService service;

  group('Filmes Service: ', () {
    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockClient();
      service = FilmsService();
    });

    test('Trazer lista de filmes', () async {
      var response = http.Response(jsonBodyFilms, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final list = await service.getFilms(httpClient);
      expect(list.isNotEmpty, equals(true));
    });

    test('Trazer um filme específico', () async {
      var response = http.Response(jsonBodyFilmsByTitle, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final film = await service.searchFilms(httpClient,
          value: 'The Empire Strikes Back');
      expect(film.any((element) => element.title! == 'The Empire Strikes Back'),
          isTrue);
    });

    test('Filme não encontrado', () async {
      var jsonBody = '{"count":0,"next":null,"previous":null,"results":[]}';
      var response = http.Response(jsonBody, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final person = await service.searchFilms(httpClient, value: 'Old');
      expect(person.any((element) => element.title!.contains('Old')), isFalse);
    });

    test('Buscar detalhes do filme', () async {
      var jsonBody =
          '{"title":"Return of the Jedi","episode_id":6,"opening_crawl":"Luke Skywalker has returned to his home planet of Tatooine in an attempt to rescue his friend Han Solo from the clutches of the vile gangster Jabba the Hutt.  Little does Luke know that the GALACTIC EMPIRE has secretly begun construction on a new armored space station even more powerful than the first dreaded Death Star.  When completed, this ultimate weapon will spell certain doom for the small band of rebels struggling to restore freedom to the galaxy...","director":"Richard Marquand","producer":"Howard G. Kazanjian, George Lucas, Rick McCallum","release_date":"1983-05-25","characters":["https://swapi.py4e.com/api/people/1/","https://swapi.py4e.com/api/people/2/","https://swapi.py4e.com/api/people/3/","https://swapi.py4e.com/api/people/4/","https://swapi.py4e.com/api/people/5/","https://swapi.py4e.com/api/people/10/","https://swapi.py4e.com/api/people/13/","https://swapi.py4e.com/api/people/14/","https://swapi.py4e.com/api/people/16/","https://swapi.py4e.com/api/people/18/","https://swapi.py4e.com/api/people/20/","https://swapi.py4e.com/api/people/21/","https://swapi.py4e.com/api/people/22/","https://swapi.py4e.com/api/people/25/","https://swapi.py4e.com/api/people/27/","https://swapi.py4e.com/api/people/28/","https://swapi.py4e.com/api/people/29/","https://swapi.py4e.com/api/people/30/","https://swapi.py4e.com/api/people/31/","https://swapi.py4e.com/api/people/45/"],"planets":["https://swapi.py4e.com/api/planets/1/","https://swapi.py4e.com/api/planets/5/","https://swapi.py4e.com/api/planets/7/","https://swapi.py4e.com/api/planets/8/","https://swapi.py4e.com/api/planets/9/"],"starships":["https://swapi.py4e.com/api/starships/2/","https://swapi.py4e.com/api/starships/3/","https://swapi.py4e.com/api/starships/10/","https://swapi.py4e.com/api/starships/11/","https://swapi.py4e.com/api/starships/12/","https://swapi.py4e.com/api/starships/15/","https://swapi.py4e.com/api/starships/17/","https://swapi.py4e.com/api/starships/22/","https://swapi.py4e.com/api/starships/23/","https://swapi.py4e.com/api/starships/27/","https://swapi.py4e.com/api/starships/28/","https://swapi.py4e.com/api/starships/29/"],"vehicles":["https://swapi.py4e.com/api/vehicles/8/","https://swapi.py4e.com/api/vehicles/16/","https://swapi.py4e.com/api/vehicles/18/","https://swapi.py4e.com/api/vehicles/19/","https://swapi.py4e.com/api/vehicles/24/","https://swapi.py4e.com/api/vehicles/25/","https://swapi.py4e.com/api/vehicles/26/","https://swapi.py4e.com/api/vehicles/30/"],"species":["https://swapi.py4e.com/api/species/1/","https://swapi.py4e.com/api/species/2/","https://swapi.py4e.com/api/species/3/","https://swapi.py4e.com/api/species/5/","https://swapi.py4e.com/api/species/6/","https://swapi.py4e.com/api/species/8/","https://swapi.py4e.com/api/species/9/","https://swapi.py4e.com/api/species/10/","https://swapi.py4e.com/api/species/15/"],"created":"2014-12-18T10:39:33.255000Z","edited":"2014-12-20T09:48:37.462000Z","url":"https://swapi.py4e.com/api/films/3/"}';
      var response = http.Response(jsonBody, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final person = await service.getFilmsById(httpClient,
          url: 'https://swapi.py4e.com/api/films/3/');
      expect(person.title!.contains('Return of the Jedi'), isTrue);
    });
  });
}
