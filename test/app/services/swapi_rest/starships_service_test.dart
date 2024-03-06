import 'package:project_starwars/app/services/swapi_rest/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:mocktail/mocktail.dart';

import 'mock_data.dart';

class MockClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late http.Client httpClient;
  late StarshipsService service;

  group('Teste StarshipsService: ', () {
    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockClient();
      service = StarshipsService();
    });

    test('Trazer uma lista de naves', () async {
      var response = http.Response(jsonBodyStarships, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final list = await service.getStarships(httpClient);
      expect(list.isNotEmpty, equals(true));
    });

    test('Trazer um nave específico', () async {
      var response = http.Response(jsonBodyStarshipsByName, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final starship =
          await service.searchStarship(httpClient, value: 'Sentinel');
      expect(starship.any((element) => element.name!.contains('Sentinel')),
          isTrue);
    });

    test('Nave não encontrada', () async {
      var jsonBody = '{"count":0,"next":null,"previous":null,"results":[]}';
      var response = http.Response(jsonBody, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final starship = await service.searchStarship(httpClient, value: 'Drone');
      expect(
          starship.any((element) => element.name!.contains('Drone')), isFalse);
    });

    test('Buscar nave por página', () async {
      var response = http.Response(jsonBodyStarships, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final infoStarships =
          await service.getStarshipsByPage(httpClient, param: 'page=1');
      expect(infoStarships.next!.contains('page=2'), isTrue);
    });

    test('Erro ao buscar nave por página', () async {
      var jsonBody = '{"detail": "Not found"}';
      var response = http.Response(jsonBody, 404);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      expect(
          () async =>
              await service.getStarshipsByPage(httpClient, param: 'page=100'),
          throwsA(isA<Exception>()));
    });
  });
}
