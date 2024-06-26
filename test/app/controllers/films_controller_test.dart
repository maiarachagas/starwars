import 'package:project_starwars/app/controllers/index.dart';
import 'package:project_starwars/app/services/bing_rest/bing_service.dart';
import 'package:project_starwars/app/services/swapi_rest/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_data.dart';

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

      await filmsController.searchFilms(value: 'Return of the Jedi');
      expect(
          filmsController.film!
              .any((element) => element.title!.contains('Return')),
          equals(true));
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

    test('Buscar detalhes do filme', () async {
      when(() => mockRepository.getFilmsById(any(), url: any(named: 'url')))
          .thenAnswer((_) async => detailsFilm);

      await filmsController.getFilmsById(
          endpoint: 'https://swapi.py4e.com/api/films/3/',
          image:
              'https://tse4.mm.bing.net/th?id=OIP.FKsBijrcaeAWzHQbO81nGQHaLI&pid=Api');
      expect(
          filmsController.filmDetail!.title!.contains('Return'), equals(true));
    });
  });
}
