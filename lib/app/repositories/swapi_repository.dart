import 'dart:convert';

import 'package:app_teste_unitario/app/models/personages_model.dart';
import 'package:http/http.dart';

import '../exceptions/api_exceptions.dart';

class SwapiRepository {
  final String _baseUrl = 'https://swapi.dev/api';
  final Map<String, String> _headers = {'Content-type': 'application/json'};

  Future<List<Personages>> getPersonages(Client client) async {
    const endpoint = 'people';
    final url = Uri.parse('$_baseUrl/$endpoint');

    try {
      var response = await client.get(url, headers: _headers);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = body['results'] as List<dynamic>;

        return list.map((value) => Personages.fromMap(value)).toList();
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

  Future<List<Personages>> searchPersonages(Client client,
      {required String value}) async {
    const endpoint = 'people';
    final params = '?search=$value';
    final url = Uri.parse('$_baseUrl/$endpoint/$params');

    try {
      var response = await client.get(url, headers: _headers);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = body['results'] as List<dynamic>;
        return list.map((value) => Personages.fromMap(value)).toList();
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

  Future<AllPersonages> getPersonagesByPage(Client client,
      {String? page}) async {
    const endpoint = 'people';
    var parameters = 'page=$page';
    final url = Uri.parse('$_baseUrl/$endpoint?$parameters');

    try {
      var response = await client.get(url, headers: _headers);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = AllPersonages.fromMap(body);

        return list;
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
