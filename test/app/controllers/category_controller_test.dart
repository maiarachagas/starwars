import 'package:app_teste_unitario/app/controllers/category_controller.dart';
import 'package:app_teste_unitario/app/services/bing_rest/bing_service.dart';
import 'package:app_teste_unitario/app/services/swapi_rest/category_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_data.dart';

class MockSwapiRepository extends Mock implements CategoryService {}

class MockBingRepository extends Mock implements BingRepository {}

class FakeClient extends Fake implements Client {}

void main() {
  late CategoryController categoryController;
  late MockSwapiRepository mockRepository;
  late MockBingRepository mockBingRepository;

  group('Personagens Controller', () {
    setUpAll(() {
      registerFallbackValue(FakeClient());
    });

    setUp(() {
      mockRepository = MockSwapiRepository();
      mockBingRepository = MockBingRepository();
      categoryController = CategoryController(
          service: mockRepository, bingRepository: mockBingRepository);
    });

    test('Exibir dados trazidos por página', () async {
      when(() => mockRepository.getDataByPage(any(),
          category: any(named: 'category'),
          param: any(named: 'param'))).thenAnswer((_) async => category);

      await categoryController.getDataByPage(
          category: 'people', page: 'page=1');

      expect(categoryController.category!.detail!.isNotEmpty, equals(true));
    });
  });
}
