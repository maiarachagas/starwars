import 'package:app_teste_unitario/app/services/swapi_rest/films_service.dart';
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
  });
}
