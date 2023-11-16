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
    });

    test('Obter todos os personagens', () async {
      when(() => mockRepository.getAllPersonages(any()))
          .thenAnswer((_) async => allPersonages);

      await personagesController.getAllPersonages();

      expect(personagesController.list!.isNotEmpty, equals(true));
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

    test('Limpar lista de todos personagens', () {
      personagesController.clearList();

      expect(personagesController.list!.isEmpty, equals(true));
    });

    test('Limpar resultado de buscar personagens', () {
      personagesController.clearSearch();
      expect(personagesController.resultSearch!.isEmpty, equals(true));
    });
  });
}
