import 'package:project_starwars/app/controllers/index.dart';
import 'package:project_starwars/app/services/bing_rest/bing_service.dart';
import 'package:project_starwars/app/services/swapi_rest/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_data.dart';

class MockSwapiRepository extends Mock implements StarshipsService {}

class MockBingRepository extends Mock implements BingRepository {}

class FakeClient extends Fake implements Client {}

void main() {
  late StarshipsController controller;
  late MockSwapiRepository mockRepository;
  late MockBingRepository mockBingRepository;

  group('Teste StarshipsController: ', () {
    setUpAll(() {
      registerFallbackValue(FakeClient());
    });

    setUp(() {
      mockRepository = MockSwapiRepository();
      mockBingRepository = MockBingRepository();
      controller = StarshipsController(
          service: mockRepository, bingRepository: mockBingRepository);
    });

    test('Obter todos os naves', () async {
      when(() => mockRepository.getStarships(any()))
          .thenAnswer((_) async => starship);

      await controller.getStarships();

      expect(controller.starship!.isNotEmpty, equals(true));
    });

    test('Trazer um nave específico', () async {
      when(() =>
              mockRepository.searchStarship(any(), value: any(named: 'value')))
          .thenAnswer((_) async => starship);

      await controller.searchStarship(value: 'Millennium Falcon');
      expect(
          controller.starship!
              .any((element) => element.name!.contains('Millennium')),
          equals(true));
    });

    test('Nave não encontrado', () async {
      when(() =>
              mockRepository.searchStarship(any(), value: any(named: 'value')))
          .thenAnswer((_) async => []);

      await controller.searchStarship(value: 'Star');
      expect(controller.starship!.isNotEmpty, equals(false));
    });

    test('Listar naves por página', () async {
      when(() => mockRepository.getStarshipsByPage(any(),
          param: any(named: 'param'))).thenAnswer((_) async => starships);

      await controller.getStarshipsByPage(page: 'page=1');
      expect(controller.starships!.starship!.isNotEmpty, equals(true));
    });

    test('Exibir naves trazidos por página', () async {
      when(() => mockRepository.getStarshipsByPage(any(),
          param: any(named: 'param'))).thenAnswer((_) async => starships);

      await controller.getStarshipsByPage(page: 'page=1');

      await controller.fetchStarships();
      expect(controller.starship!.isNotEmpty, equals(true));
    });

    test('Limpar lista de todos naves', () {
      controller.clearList();

      expect(controller.starship!.isEmpty, equals(true));
    });

    test('Atribuindo imagem ao naves', () async {
      when(() => mockBingRepository.getImageByBing(any(),
          param: any(named: 'param'))).thenAnswer((_) async => infoImage);
      await controller.attributeImageToStarship(starship);

      expect(
          controller.starship!
              .any((element) => element.thumbnailUrl.toString().isNotEmpty),
          isTrue);
    });
  });
}
