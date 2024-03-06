import 'package:project_starwars/app/exceptions/api_exceptions.dart';
import 'package:project_starwars/app/services/bing_rest/bing_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

class FakeUri extends Fake implements Uri {}

void main() {
  late http.Client httpClient;
  late BingRepository repository;
  setUpAll(() {
    registerFallbackValue(FakeUri());
  });

  setUp(() {
    httpClient = MockClient();
    repository = BingRepository();
  });
  test('Trazendo imagens', () async {
    var jsonBody =
        '{"_type": "Images", "instrumentation": {"_type": "ResponseInstrumentation"}, "readLink": "images/search?q=luke %skywalker %starwars", "webSearchUrl": "https://www.bing.com/images/search?q=luke %skywalker %starwars&FORM=OIIARP", "queryContext": {"originalQuery": "luke %skywalker %starwars", "alterationDisplayQuery": "luke %skywalker %star wars", "alterationOverrideQuery": "+luke %skywalker %starwars", "alterationMethod": "AM_ChangeItWithRecourse", "alterationType": "CombinedAlterationsChained"}, "totalEstimatedMatches": 511, "nextOffset": 70, "currentOffset": 0, "value":[{"webSearchUrl": "https://www.bing.com/images/search?view=detailv2&FORM=OIIRPO&q=luke+%25skywalker+%25starwars&id=FFD59ED05A26A33C503B66BE02C8CFFA05FA8DB3&simid=608011883325245696", "name": "Luke Skywalker - Heroes Wiki", "thumbnailUrl": "https://tse1.mm.bing.net/th?id=OIP.uPTRLR8uspCiafiunUqKfQHaMJ&pid=Api", "datePublished": "2014-12-24T11:07:00.0000000Z", "isFamilyFriendly": true, "contentUrl": "http://img1.wikia.nocookie.net/__cb20141111160806/p__/protagonist/images/8/84/Lukeskywalker.jpg", "hostPageUrl": "http://hero.wikia.com/wiki/Luke_Skywalker", "contentSize": "421810 B", "encodingFormat": "jpeg", "hostPageDisplayUrl": "hero.wikia.com/wiki/Luke_Skywalker", "width": 1647, "height": 2700, "hostPageFavIconUrl": "https://www.bing.com/th?id=ODF.2pvnAG7RKofUGMFIut-1PQ&pid=Api", "hostPageDiscoveredDate": "2014-04-08T00:00:00.0000000Z", "isTransparent": false, "thumbnail": {"width": 474, "height": 777}, "imageInsightsToken": "ccid_uPTRLR8u*cp_64790184029AA8C48281267F9124289B*mid_FFD59ED05A26A33C503B66BE02C8CFFA05FA8DB3*simid_608011883325245696*thid_OIP.uPTRLR8uspCiafiunUqKfQHaMJ", "insightsMetadata": {"recipeSourcesCount": 0, "pagesIncludingCount": 97, "availableSizesCount": 51}, "imageId": "FFD59ED05A26A33C503B66BE02C8CFFA05FA8DB3", "accentColor": "2B6FA0"}]}';

    var response = http.Response(jsonBody, 200);

    when(() => httpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => response);

    final image =
        await repository.getImageByBing(httpClient, param: 'Leia Organa');
    expect(image.any((element) => element.thumbnailUrl!.isNotEmpty), isTrue);
  });

  test('Erro ao trazer imagens', () async {
    var jsonBody =
        '{"_type": "ErrorResponse", "instrumentation": {"_type": "ResponseInstrumentation"}, "errors": [{"code": "InvalidRequest", "subCode": "ParameterMissing", "message": "Required parameter is missing.", "moreDetails": "Required parameter is missing.", "parameter": "q", "value": ""}]}';

    var response = http.Response(jsonBody, 400);

    when(() => httpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => response);

    expect(
      () async =>
          await repository.getImageByBing(httpClient, param: 'Leia Organa'),
      throwsA(isA<ApiException>()),
    );
  });
}
