import 'package:app_teste_unitario/app/services/swapi_rest/species_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:mocktail/mocktail.dart';

import 'mock_data.dart';

class MockClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late http.Client httpClient;
  late SpeciesService service;

  group('Teste SpeciesService: ', () {
    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockClient();
      service = SpeciesService();
    });

    test('Trazer uma lista de especies', () async {
      var response = http.Response(jsonBodySpecies, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final list = await service.getSpecies(httpClient);
      expect(list.isNotEmpty, equals(true));
    });

    test('Trazer um especie específico', () async {
      var response = http.Response(jsonBodySpeciesByName, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final specie = await service.searchSpecie(httpClient, value: 'Droid');
      expect(specie.any((element) => element.name!.contains('Droid')), isTrue);
    });

    test('Espécie não encontrada', () async {
      var jsonBody = '{"count":0,"next":null,"previous":null,"results":[]}';
      var response = http.Response(jsonBody, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final specie = await service.searchSpecie(httpClient, value: 'Drone');
      expect(specie.any((element) => element.name!.contains('Drone')), isFalse);
    });

    test('Buscar espécie por página', () async {
      var response = http.Response(jsonBodySpecies, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final infoSpecies =
          await service.getSpeciesByPage(httpClient, param: 'page=1');
      expect(infoSpecies.next!.contains('page=2'), isTrue);
    });

    test('Erro ao buscar espécie por página', () async {
      var jsonBody = '{"detail": "Not found"}';
      var response = http.Response(jsonBody, 404);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      expect(
          () async =>
              await service.getSpeciesByPage(httpClient, param: 'page=100'),
          throwsA(isA<Exception>()));
    });
  });
}
