import 'package:app_teste_unitario/app/controllers/personages_controller.dart';
import 'package:app_teste_unitario/app/models/bing_model.dart';
import 'package:app_teste_unitario/app/models/personages_model.dart';
import 'package:app_teste_unitario/app/services/bing_rest/bing_service.dart';
import 'package:app_teste_unitario/app/services/swapi_rest/personages_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockSwapiRepository extends Mock implements PersonagesService {}

class MockBingRepository extends Mock implements BingRepository {}

class FakeClient extends Fake implements Client {}

void main() {
  late PersonagesController personagesController;
  late MockSwapiRepository mockRepository;
  late MockBingRepository mockBingRepository;

  List<Personage> personage = [];
  Personages personages = Personages();
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
      personage = [
        Personage(name: 'Luke Skywalker'),
        Personage(name: 'Darth Vader'),
        Personage(name: 'Leia Organa'),
      ];

      personages =
          Personages(count: 80, next: '2', previous: '0', personage: personage);

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
          .thenAnswer((_) async => personage);

      await personagesController.getPersonages();

      expect(personagesController.personage!.isNotEmpty, equals(true));
    });

    test('Trazer um personagem específico', () async {
      when(() => mockRepository.searchPersonages(any(),
          value: any(named: 'value'))).thenAnswer((_) async => personage);

      await personagesController.searchPersonages(value: 'Leia');
      expect(personagesController.personage!.isNotEmpty, equals(true));
    });

    test('Personagem não encontrado', () async {
      when(() => mockRepository.searchPersonages(any(),
          value: any(named: 'value'))).thenAnswer((_) async => []);

      await personagesController.searchPersonages(value: 'Lucas');
      expect(personagesController.personage!.isNotEmpty, equals(false));
    });

    test('Listar Personagens por página', () async {
      when(() => mockRepository.getPersonagesByPage(any(),
          param: any(named: 'param'))).thenAnswer((_) async => personages);

      await personagesController.getPersonagesByPage(page: 'page=1');
      expect(
          personagesController.personages!.personage!.isNotEmpty, equals(true));
    });

    test('Exibir personagens trazidos por página', () async {
      when(() => mockRepository.getPersonagesByPage(any(),
          param: any(named: 'param'))).thenAnswer((_) async => personages);

      await personagesController.getPersonagesByPage(page: 'page=1');

      await personagesController.fetchPersonages();
      expect(personagesController.personage!.isNotEmpty, equals(true));
    });

    test('Limpar lista de todos personagens', () {
      personagesController.clearList();

      expect(personagesController.personage!.isEmpty, equals(true));
    });

    test('Atribuindo imagem ao personagem', () async {
      when(() => mockBingRepository.getImageByBing(any(),
          param: any(named: 'param'))).thenAnswer((_) async => infoImage);
      await personagesController.attributeImageToPerson(personage);

      expect(
          personagesController.personage!
              .any((element) => element.thumbnailUrl.toString().isNotEmpty),
          isTrue);
    });
  });
}
