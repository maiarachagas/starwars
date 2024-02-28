import 'package:app_teste_unitario/app/services/swapi_rest/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:mocktail/mocktail.dart';

import 'mock_data.dart';

class MockClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late http.Client httpClient;
  late VehiclesService service;

  group('Teste VehiclesService: ', () {
    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      httpClient = MockClient();
      service = VehiclesService();
    });

    test('Trazer uma lista de veiculos', () async {
      var response = http.Response(jsonBodyVehicles, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final list = await service.getVehicles(httpClient);
      expect(list.isNotEmpty, equals(true));
    });

    test('Trazer um veiculo específico', () async {
      var response = http.Response(jsonBodyVehiclesByName, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final vehicle =
          await service.searchVehicle(httpClient, value: 'Sand Crawler');
      expect(vehicle.any((element) => element.name!.contains('Sand')), isTrue);
    });

    test('Veiculo não encontrada', () async {
      var jsonBody = '{"count":0,"next":null,"previous":null,"results":[]}';
      var response = http.Response(jsonBody, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final vehicle = await service.searchVehicle(httpClient, value: 'Drone');
      expect(
          vehicle.any((element) => element.name!.contains('Drone')), isFalse);
    });

    test('Buscar veiculo por página', () async {
      var response = http.Response(jsonBodyVehicles, 200);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      final infoVehicles =
          await service.getVehiclesByPage(httpClient, param: 'page=1');
      expect(infoVehicles.next!.contains('page=2'), isTrue);
    });

    test('Erro ao buscar veiculo por página', () async {
      var jsonBody = '{"detail": "Not found"}';
      var response = http.Response(jsonBody, 404);

      when(() => httpClient.get(any(), headers: any(named: 'headers')))
          .thenAnswer((_) async => response);

      expect(
          () async =>
              await service.getVehiclesByPage(httpClient, param: 'page=100'),
          throwsA(isA<Exception>()));
    });
  });
}
