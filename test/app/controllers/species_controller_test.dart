import 'package:app_teste_unitario/app/controllers/species_controller.dart';
import 'package:app_teste_unitario/app/services/bing_rest/bing_service.dart';
import 'package:app_teste_unitario/app/services/swapi_rest/species_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_data.dart';

class MockSwapiRepository extends Mock implements SpeciesService {}

class MockBingRepository extends Mock implements BingRepository {}

class FakeClient extends Fake implements Client {}

void main() {
  late SpeciesController controller;
  late MockSwapiRepository mockRepository;
  late MockBingRepository mockBingRepository;

  group('Teste PlanetsController: ', () {
    setUpAll(() {
      registerFallbackValue(FakeClient());
    });

    setUp(() {
      mockRepository = MockSwapiRepository();
      mockBingRepository = MockBingRepository();
      controller = SpeciesController(
          service: mockRepository, bingRepository: mockBingRepository);
    });

    test('Obter todos os planetas', () async {
      when(() => mockRepository.getSpecies(any()))
          .thenAnswer((_) async => specie);

      await controller.getSpecies();

      expect(controller.specie!.isNotEmpty, equals(true));
    });

    test('Trazer um planeta específico', () async {
      when(() => mockRepository.searchSpecie(any(), value: any(named: 'value')))
          .thenAnswer((_) async => specie);

      await controller.searchSpecie(value: 'Human');
      expect(
          controller.specie!.any((element) => element.name!.contains('Human')),
          equals(true));
    });

    test('Planeta não encontrado', () async {
      when(() => mockRepository.searchSpecie(any(), value: any(named: 'value')))
          .thenAnswer((_) async => []);

      await controller.searchSpecie(value: 'Drone');
      expect(controller.specie!.isNotEmpty, equals(false));
    });

    test('Listar Planetas por página', () async {
      when(() => mockRepository.getSpeciesByPage(any(),
          param: any(named: 'param'))).thenAnswer((_) async => species);

      await controller.getSpeciesByPage(page: 'page=1');
      expect(controller.species!.specie!.isNotEmpty, equals(true));
    });

    test('Exibir planetas trazidos por página', () async {
      when(() => mockRepository.getSpeciesByPage(any(),
          param: any(named: 'param'))).thenAnswer((_) async => species);

      await controller.getSpeciesByPage(page: 'page=1');

      await controller.fetchSpecies();
      expect(controller.specie!.isNotEmpty, equals(true));
    });

    test('Limpar lista de todos planetas', () {
      controller.clearList();

      expect(controller.specie!.isEmpty, equals(true));
    });

    test('Atribuindo imagem ao planeta', () async {
      when(() => mockBingRepository.getImageByBing(any(),
          param: any(named: 'param'))).thenAnswer((_) async => infoImage);
      await controller.attributeImageToSpecie(specie);

      expect(
          controller.specie!
              .any((element) => element.thumbnailUrl.toString().isNotEmpty),
          isTrue);
    });
  });
}
