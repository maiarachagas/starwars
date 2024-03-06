import 'package:project_starwars/app/controllers/index.dart';
import 'package:project_starwars/app/services/bing_rest/bing_service.dart';
import 'package:project_starwars/app/services/swapi_rest/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_data.dart';

class MockSwapiRepository extends Mock implements PlanetsService {}

class MockBingRepository extends Mock implements BingRepository {}

class FakeClient extends Fake implements Client {}

void main() {
  late PlanetsController planetsController;
  late MockSwapiRepository mockRepository;
  late MockBingRepository mockBingRepository;

  group('Teste PlanetsController: ', () {
    setUpAll(() {
      registerFallbackValue(FakeClient());
    });

    setUp(() {
      mockRepository = MockSwapiRepository();
      mockBingRepository = MockBingRepository();
      planetsController = PlanetsController(
          service: mockRepository, bingRepository: mockBingRepository);
    });

    test('Obter todos os planetas', () async {
      when(() => mockRepository.getPlanets(any()))
          .thenAnswer((_) async => planet);

      await planetsController.getPlanets();

      expect(planetsController.planet!.isNotEmpty, equals(true));
    });

    test('Trazer um planeta específico', () async {
      when(() => mockRepository.searchPlanet(any(), value: any(named: 'value')))
          .thenAnswer((_) async => planet);

      await planetsController.searchPlanet(value: 'Tatooine');

      expect(
          planetsController.planet!
              .any((element) => element.name!.contains('Tatooine')),
          equals(true));
    });

    test('Planeta não encontrado', () async {
      when(() => mockRepository.searchPlanet(any(), value: any(named: 'value')))
          .thenAnswer((_) async => []);

      await planetsController.searchPlanet(value: 'Tattoine');
      expect(planetsController.planet!.isNotEmpty, equals(false));
    });

    test('Listar Planetas por página', () async {
      when(() => mockRepository.getPlanetsByPage(any(),
          param: any(named: 'param'))).thenAnswer((_) async => planets);

      await planetsController.getPlanetsByPage(page: 'page=1');
      expect(planetsController.planets!.planet!.isNotEmpty, equals(true));
    });

    test('Exibir planetas trazidos por página', () async {
      when(() => mockRepository.getPlanetsByPage(any(),
          param: any(named: 'param'))).thenAnswer((_) async => planets);

      await planetsController.getPlanetsByPage(page: 'page=1');

      await planetsController.fetchPlanets();
      expect(planetsController.planet!.isNotEmpty, equals(true));
    });

    test('Limpar lista de todos planetas', () {
      planetsController.clearList();

      expect(planetsController.planet!.isEmpty, equals(true));
    });

    test('Atribuindo imagem ao planeta', () async {
      when(() => mockBingRepository.getImageByBing(any(),
          param: any(named: 'param'))).thenAnswer((_) async => infoImage);
      await planetsController.attributeImageToPlanet(planet);

      expect(
          planetsController.planet!
              .any((element) => element.thumbnailUrl.toString().isNotEmpty),
          isTrue);
    });
  });
}
