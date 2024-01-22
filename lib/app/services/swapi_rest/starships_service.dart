import 'package:app_teste_unitario/app/services/swapi_rest/swapi_api.dart';
import 'dart:convert';

import 'package:http/http.dart';

import '../../exceptions/api_exceptions.dart';
import '../../models/starships_model.dart';
import 'swapi_api.dart';

class StarshipsService extends SwapiApi {
  Future<List<Starship>> getStarships(Client client) async {
    const endpoint = 'starships';

    try {
      var response = await callGet(client, endpoint);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = body['results'] as List<dynamic>;

        return list.map((value) => Starship.fromMap(value)).toList();
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

  Future<List<Starship>> searchStarship(Client client,
      {required String value}) async {
    const endpoint = 'starships';
    final params = '?search=$value';

    try {
      var response = await callGet(client, endpoint + params);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = body['results'] as List<dynamic>;
        return list.map((value) => Starship.fromMap(value)).toList();
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

  Future<Starships> getStarshipsByPage(Client client, {String? param}) async {
    const endpoint = 'starships';
    final params = '?$param';
    final url = baseUrl + endpoint + params;

    try {
      var response = await callGet(client, endpoint + params);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = Starships.fromMap(body, url);

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
