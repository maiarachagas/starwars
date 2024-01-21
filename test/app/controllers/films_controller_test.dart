import 'package:app_teste_unitario/app/controllers/films_controller.dart';
import 'package:app_teste_unitario/app/models/bing_model.dart';
import 'package:app_teste_unitario/app/services/bing_rest/bing_service.dart';
import 'package:app_teste_unitario/app/services/swapi_rest/films_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import '../services/swapi_rest/mock_swapi_data.dart';

class MockSwapiRepository extends Mock implements FilmsService {}

class MockBingRepository extends Mock implements BingRepository {}

class FakeClient extends Fake implements Client {}

void main() {
  late FilmsController filmsController;
  late MockSwapiRepository mockRepository;
  late MockBingRepository mockBingRepository;

  group('Teste FilmsController:', () {
    setUpAll(() {
      registerFallbackValue(FakeClient());
    });

    setUp(() {
      mockRepository = MockSwapiRepository();
      mockBingRepository = MockBingRepository();
      filmsController = FilmsController(
          service: mockRepository, bingRepository: mockBingRepository);
    });

    test('Obter todos os filmes', () async {
      when(() => mockRepository.getFilms(any())).thenAnswer((_) async => film);

      await filmsController.getFilms();

      expect(filmsController.film!.isNotEmpty, equals(true));
    });

    test('Trazer um filme específico', () async {
      when(() => mockRepository.searchFilms(any(), value: any(named: 'value')))
          .thenAnswer((_) async => film);

      await filmsController.searchFilms(value: 'Leia');
      expect(filmsController.film!.isNotEmpty, equals(true));
    });

    test('Filme não encontrado', () async {
      when(() => mockRepository.searchFilms(any(), value: any(named: 'value')))
          .thenAnswer((_) async => []);

      await filmsController.searchFilms(value: 'Lucas');
      expect(filmsController.film!.isNotEmpty, equals(false));
    });

    test('Limpar lista de todos filmes', () {
      filmsController.clearList();

      expect(filmsController.film!.isEmpty, equals(true));
    });

    test('Atribuindo imagem ao filme', () async {
      when(() => mockBingRepository.getImageByBing(any(),
          param: any(named: 'param'))).thenAnswer((_) async => infoImage);
      await filmsController.attributeImageToFilm(film);

      expect(
          filmsController.film!
              .any((element) => element.thumbnailUrl.toString().isNotEmpty),
          isTrue);
    });
  });
}
