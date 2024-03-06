import 'package:project_starwars/app/controllers/index.dart';
import 'package:project_starwars/app/services/bing_rest/bing_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_data.dart';

class MockBingRepository extends Mock implements BingRepository {}

class FakeClient extends Fake implements Client {}

void main() {
  late BingImagesController bingImagesController;
  late MockBingRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeClient());
  });

  setUp(() {
    mockRepository = MockBingRepository();
    bingImagesController = BingImagesController(repository: mockRepository);
  });

  test('Buscar imagens', () async {
    when(() => mockRepository.getImageByBing(any(), param: any(named: 'param')))
        .thenAnswer((_) async => infoImage);
    await bingImagesController.getImageByBing(name: 'Luke Skywalker');

    expect(bingImagesController.image!.isNotEmpty, isTrue);
  });

  test('Erro Buscar imagens', () async {
    when(() => mockRepository.getImageByBing(any(), param: any(named: 'param')))
        .thenAnswer((_) async => []);
    await bingImagesController.getImageByBing(name: '');

    expect(bingImagesController.image!.isEmpty, isTrue);
  });

  test('Atribuindo imagem ao personagem', () async {
    when(() => mockRepository.getImageByBing(any(), param: any(named: 'param')))
        .thenAnswer((_) async => infoImage);

    await bingImagesController.attributeImageToPerson(personage);

    expect(
        bingImagesController.imagePerson
            .any((element) => element['name'].toString().isNotEmpty),
        isTrue);
  });

  test('Erro ao atribuir imagem ao personagem', () async {
    when(() => mockRepository.getImageByBing(any(), param: any(named: 'param')))
        .thenAnswer((_) async => infoImage);
    await bingImagesController.attributeImageToPerson([]);

    expect(bingImagesController.imagePerson.isEmpty, isTrue);
  });
}
