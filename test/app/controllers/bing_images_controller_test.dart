import 'package:app_teste_unitario/app/controllers/bing_images_controller.dart';
import 'package:app_teste_unitario/app/exceptions/api_exceptions.dart';
import 'package:app_teste_unitario/app/models/bing_model.dart';
import 'package:app_teste_unitario/app/models/personages_model.dart';
import 'package:app_teste_unitario/app/repositories/bing_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockBingRepository extends Mock implements BingRepository {}

class FakeClient extends Fake implements Client {}

void main() {
  late BingImagesController bingImagesController;
  late MockBingRepository mockRepository;
  List<InfoImage> infoImage = [];
  List<Personages> allPersonages = [];

  setUpAll(() {
    registerFallbackValue(FakeClient());
  });

  setUp(() {
    mockRepository = MockBingRepository();
    bingImagesController = BingImagesController();
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
    allPersonages = [
      Personages(name: 'Luke Skywalker'),
      Personages(name: 'Darth Vader'),
      Personages(name: 'R2D2'),
    ];
  });

  test('Buscar imagens', () async {
    when(() => mockRepository.getImageByBing(any(), param: any(named: 'param')))
        .thenAnswer((_) async => infoImage);
    await bingImagesController.getImageByBing(name: 'Luke Skywalker');

    expect(bingImagesController.image!.isNotEmpty, isTrue);
  });

  test('Erro Buscar imagens', () async {
    when(() => mockRepository.getImageByBing(any(), param: any(named: 'param')))
        .thenAnswer((_) async => infoImage);

    expect(
      () async => await bingImagesController.getImageByBing(name: ''),
      throwsA(isA<ApiException>()),
    );
  });

  test('Atribuindo imagem ao personagem', () async {
    when(() => mockRepository.getImageByBing(any(), param: any(named: 'param')))
        .thenAnswer((_) async => infoImage);

    await bingImagesController.attributeImageToPerson(allPersonages);

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
