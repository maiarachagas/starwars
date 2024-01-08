import 'package:app_teste_unitario/app/controllers/personages_controller.dart';
import 'package:app_teste_unitario/app/models/personages_model.dart';
import 'package:app_teste_unitario/app/repositories/swapi_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockSwapiRepository extends Mock implements SwapiRepository {}

class FakeClient extends Fake implements Client {}

void main() {
  late PersonagesController personagesController;
  late MockSwapiRepository mockRepository;
  List<Personages> allPersonages = [];
  List<Personages> personages = [];
  AllPersonages allInfoPersonages = AllPersonages();

  group('Personagens Controller', () {
    setUpAll(() {
      registerFallbackValue(FakeClient());
    });

    setUp(() {
      mockRepository = MockSwapiRepository();
      personagesController = PersonagesController();
      allPersonages = [
        Personages(name: 'Luke Skywalker'),
        Personages(name: 'Darth Vader'),
      ];
      personages = [
        Personages(name: 'Leia Organa'),
      ];

      allInfoPersonages = AllPersonages(
          count: 80, next: '2', previous: '0', personages: personages);
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
          value: any(named: 'value'))).thenAnswer((_) async => personages);

      await personagesController.searchPersonages(value: 'Lucas');
      expect(personagesController.resultSearch!.isNotEmpty, equals(false));
    });

    test('Listar Personagens por página', () async {
      when(() => mockRepository.getPersonagesByPage(any(),
          page: any(named: 'page'))).thenAnswer((_) async => allInfoPersonages);

      await personagesController.getPersonagesByPage(page: '1');
      expect(personagesController.allPersonages!.personages!.isNotEmpty,
          equals(true));
    });

    test('Exibir personagens trazidos por página', () async {
      when(() => mockRepository.getPersonagesByPage(any(),
          page: any(named: 'page'))).thenAnswer((_) async => allInfoPersonages);

      await personagesController.getPersonagesByPage(page: '1');

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
  });
}
