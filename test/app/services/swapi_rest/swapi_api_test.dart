import 'package:project_starwars/app/services/swapi_rest/swapi_api.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late http.Client httpClient;
  late SwapiApi api;

  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    httpClient = MockClient();
    api = SwapiApi();
  });

  test('get() deve retornar uma resposta HTTP', () async {
    when(() => httpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => Response('{"name": "Luke Skywalker"}', 200));

    var response = await api.callGet(httpClient, 'people/1');

    expect(response.statusCode, 200);
    expect(response.body, '{"name": "Luke Skywalker"}');
  });
}
