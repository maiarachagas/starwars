import 'dart:convert';

import 'package:project_starwars/app/models/bing_model.dart';
import 'package:project_starwars/env.dart';
import 'package:http/http.dart';

import '../../exceptions/api_exceptions.dart';

class BingRepository {
  final String _baseUrl = AppConfig.apiUrl;
  final Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Ocp-Apim-Subscription-Key': AppConfig.apiKey
  };

  Future<List<InfoImage>> getImageByBing(Client client, {String? param}) async {
    const endpoint = 'images/search';
    var parameters = 'mkt=pt-BR&q=starwars${param!.replaceAll(' ', '%20')}';

    final url = Uri.parse('$_baseUrl/$endpoint?$parameters');
    try {
      var response = await client.get(url, headers: _headers);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = body['value'] as List<dynamic>;
        return list.map((value) => InfoImage.fromMap(value)).toList();
      } else {
        throw [
          ApiException(
              message: 'Erro na requisição',
              code: response.statusCode.toString(),
              details: '${DateTime.now()} - ${response.body}')
        ];
      }
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }
}
