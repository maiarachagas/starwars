import 'dart:convert';

import 'package:app_teste_unitario/app/models/bing_model.dart';
import 'package:http/http.dart';

import '../exceptions/api_exceptions.dart';

class BingRepository {
  final String _baseUrl = 'https://api.bing.microsoft.com/v7.0';
  final Map<String, String> _headers = {
    'Content-type': 'application/json',
    'Ocp-Apim-Subscription-Key': '619ee56b78e8449d934c274565c4e306'
  };

  Future<List<InfoImage>> getImageByBing(Client client, {String? param}) async {
    const endpoint = 'images/search';
    var parameters = 'mkt=pt-BR&q=${param!.replaceAll(' ', '%20')}';

    final url = Uri.parse('$_baseUrl/$endpoint?$parameters');
    try {
      var response = await client.get(url, headers: _headers);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = body['value'] as List<dynamic>;
        return list.map((value) => InfoImage.fromMap(value)).toList();
      } else {
        throw ApiException(
            message: 'Erro na requisição',
            code: response.statusCode.toString(),
            details: '${DateTime.now()} - ${response.body}');
      }
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }
}
