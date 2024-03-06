import 'package:project_starwars/app/controllers/index.dart';
import 'package:project_starwars/app/services/bing_rest/bing_service.dart';
import 'package:project_starwars/app/services/swapi_rest/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_data.dart';

class MockSwapiRepository extends Mock implements VehiclesService {}

class MockBingRepository extends Mock implements BingRepository {}

class FakeClient extends Fake implements Client {}

void main() {
  late VehiclesController controller;
  late MockSwapiRepository mockRepository;
  late MockBingRepository mockBingRepository;

  group('Teste VehiclesController: ', () {
    setUpAll(() {
      registerFallbackValue(FakeClient());
    });

    setUp(() {
      mockRepository = MockSwapiRepository();
      mockBingRepository = MockBingRepository();
      controller = VehiclesController(
          service: mockRepository, bingRepository: mockBingRepository);
    });

    test('Obter todos os veiculos', () async {
      when(() => mockRepository.getVehicles(any()))
          .thenAnswer((_) async => vehicle);

      await controller.getVehicles();

      expect(controller.vehicle!.isNotEmpty, equals(true));
    });

    test('Trazer um veiculo específico', () async {
      when(() =>
              mockRepository.searchVehicle(any(), value: any(named: 'value')))
          .thenAnswer((_) async => vehicle);

      await controller.searchVehicle(value: 'Sand Crawler');
      expect(
          controller.vehicle!.any((element) => element.name!.contains('Sand')),
          equals(true));
    });

    test('Veiculo não encontrado', () async {
      when(() =>
              mockRepository.searchVehicle(any(), value: any(named: 'value')))
          .thenAnswer((_) async => []);

      await controller.searchVehicle(value: 'Sandy');
      expect(controller.vehicle!.isNotEmpty, equals(false));
    });

    test('Listar veiculos por página', () async {
      when(() => mockRepository.getVehiclesByPage(any(),
          param: any(named: 'param'))).thenAnswer((_) async => vehicles);

      await controller.getVehiclesByPage(page: 'page=1');
      expect(controller.vehicles!.vehicle!.isNotEmpty, equals(true));
    });

    test('Exibir veiculos trazidos por página', () async {
      when(() => mockRepository.getVehiclesByPage(any(),
          param: any(named: 'param'))).thenAnswer((_) async => vehicles);

      await controller.getVehiclesByPage(page: 'page=1');

      await controller.fetchVehicles();
      expect(controller.vehicle!.isNotEmpty, equals(true));
    });

    test('Limpar lista de todos veiculos', () {
      controller.clearList();

      expect(controller.vehicle!.isEmpty, equals(true));
    });

    test('Atribuindo imagem ao veiculo', () async {
      when(() => mockBingRepository.getImageByBing(any(),
          param: any(named: 'param'))).thenAnswer((_) async => infoImage);
      await controller.attributeImageToVehicle(vehicle);

      expect(
          controller.vehicle!
              .any((element) => element.thumbnailUrl.toString().isNotEmpty),
          isTrue);
    });
  });
}
