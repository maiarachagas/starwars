import 'package:app_teste_unitario/app/services/swapi_rest/planets_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:mocktail/mocktail.dart';

import 'mock_data.dart';

class MockClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late http.Client httpClient;
  late PlanetsService service;

  group('Teste PlanetsService: ', () {
    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockClient();
      service = PlanetsService();
    });

    test('Trazer uma lista de planetas', () async {
      var response = http.Response(jsonBodyPlanets, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final list = await service.getPlanets(httpClient);
      expect(list.isNotEmpty, equals(true));
    });

    test('Trazer um planeta específico', () async {
      var response = http.Response(jsonBodyPlanetByName, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final planet = await service.searchPlanet(httpClient, value: 'Tatooine');
      expect(
          planet.any((element) => element.name!.contains('Tatooine')), isTrue);
    });

    test('Planeta não encontrado', () async {
      var jsonBody = '{"count":0,"next":null,"previous":null,"results":[]}';
      var response = http.Response(jsonBody, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final planet = await service.searchPlanet(httpClient, value: 'Tattoine');
      expect(
          planet.any((element) => element.name!.contains('Tattoine')), isFalse);
    });

    test('Buscar planeta por página', () async {
      var response = http.Response(jsonBodyPlanets, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final infoPlanets =
          await service.getPlanetsByPage(httpClient, param: 'page=1');
      expect(infoPlanets.next!.contains('page=2'), isTrue);
    });

    test('Erro ao buscar planeta por página', () async {
      var jsonBody = '{"detail": "Not found"}';
      var response = http.Response(jsonBody, 404);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      expect(
          () async =>
              await service.getPlanetsByPage(httpClient, param: 'page=100'),
          throwsA(isA<Exception>()));
    });
  });
}
