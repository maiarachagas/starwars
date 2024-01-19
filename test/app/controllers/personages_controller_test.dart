import 'package:app_teste_unitario/app/controllers/personages_controller.dart';
import 'package:app_teste_unitario/app/models/bing_model.dart';
import 'package:app_teste_unitario/app/models/personages_model.dart';
import 'package:app_teste_unitario/app/repositories/bing_repository.dart';
import 'package:app_teste_unitario/app/repositories/swapi_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockSwapiRepository extends Mock implements SwapiRepository {}

class MockBingRepository extends Mock implements BingRepository {}

class FakeClient extends Fake implements Client {}

void main() {
  late PersonagesController personagesController;
  late MockSwapiRepository mockRepository;
  late MockBingRepository mockBingRepository;

  List<Personages> allPersonages = [];
  List<Personages> personages = [];
  AllPersonages allInfoPersonages = AllPersonages();
  List<InfoImage> infoImage = [];

  group('Personagens Controller', () {
    setUpAll(() {
      registerFallbackValue(FakeClient());
    });

    setUp(() {
      mockRepository = MockSwapiRepository();
      mockBingRepository = MockBingRepository();
      personagesController = PersonagesController(
          repository: mockRepository, bingRepository: mockBingRepository);
      allPersonages = [
        Personages(name: 'Luke Skywalker'),
        Personages(name: 'Darth Vader'),
        Personages(name: 'Leia Organa'),
      ];
      personages = [
        Personages(name: 'Leia Organa'),
      ];

      allInfoPersonages = AllPersonages(
          count: 80, next: '2', previous: '0', personages: personages);

      infoImage = [
        InfoImage(
            thumbnailUrl:
                'https://tse4.mm.bing.net/th?id=OIP.FKsBijrcaeAWzHQbO81nGQHaLI&pid=Api'),
        InfoImage(
            thumbnailUrl:
                'https://tse4.mm.bing.net/th?id=OIP.YhUlntbH98C7Vi-uKF0xlwHaFj&pid=Api'),
        InfoImage(
            thumbnailUrl:
                'https://tse1.mm.bing.net/th?id=OIP.w25ZoCwIb9HMq9xZSNUWmgHaH4&pid=Api')
      ];
    });

    test('Obter todos os personagens', () async {
      when(() => mockRepository.getPersonages(any()))
          .thenAnswer((_) async => allPersonages);

      await personagesController.getPersonages();

      expect(personagesController.personages!.isNotEmpty, equals(true));
    });

    test('Trazer um personagem específico', () async {
      when(() => mockRepository.searchPersonages(any(),
          value: any(named: 'value'))).thenAnswer((_) async => personages);

      await personagesController.searchPersonages(value: 'Leia');
      expect(personagesController.resultSearch!.isNotEmpty, equals(true));
    });

    test('Personagem não encontrado', () async {
      when(() => mockRepository.searchPersonages(any(),
          value: any(named: 'value'))).thenAnswer((_) async => []);

      await personagesController.searchPersonages(value: 'Lucas');
      expect(personagesController.resultSearch!.isNotEmpty, equals(false));
    });

    test('Listar Personagens por página', () async {
      when(() => mockRepository.getPersonagesByPage(any(),
              param: any(named: 'param')))
          .thenAnswer((_) async => allInfoPersonages);

      await personagesController.getPersonagesByPage(page: 'page=1');
      expect(personagesController.allPersonages!.personages!.isNotEmpty,
          equals(true));
    });

    test('Exibir personagens trazidos por página', () async {
      when(() => mockRepository.getPersonagesByPage(any(),
              param: any(named: 'param')))
          .thenAnswer((_) async => allInfoPersonages);

      await personagesController.getPersonagesByPage(page: 'page=1');

      await personagesController.fetchPersonages();
      expect(personagesController.personages!.isNotEmpty, equals(true));
    });

    test('Limpar lista de todos personagens', () {
      personagesController.clearList();

      expect(personagesController.personages!.isEmpty, equals(true));
    });

    test('Limpar resultado de buscar personagens', () {
      personagesController.clearSearch();
      expect(personagesController.resultSearch!.isEmpty, equals(true));
    });

    test('Atribuindo imagem ao personagem', () async {
      when(() => mockBingRepository.getImageByBing(any(),
          param: any(named: 'param'))).thenAnswer((_) async => infoImage);
      await personagesController.attributeImageToPerson(allPersonages);

      expect(
          personagesController.personages!
              .any((element) => element.thumbnailUrl.toString().isNotEmpty),
          isTrue);
    });
  });
}
