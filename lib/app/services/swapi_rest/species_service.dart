import 'package:app_teste_unitario/app/models/species_model.dart';
import 'package:app_teste_unitario/app/services/swapi_rest/swapi_api.dart';
import 'dart:convert';

import 'package:http/http.dart';

import '../../exceptions/api_exceptions.dart';
import 'swapi_api.dart';

class SpeciesService extends SwapiApi {
  Future<List<Specie>> getSpecies(Client client) async {
    const endpoint = 'species';

    try {
      var response = await callGet(client, endpoint);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = body['results'] as List<dynamic>;

        return list.map((value) => Specie.fromMap(value)).toList();
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

  Future<List<Specie>> searchSpecie(Client client,
      {required String value}) async {
    const endpoint = 'species';
    final params = '?search=$value';

    try {
      var response = await callGet(client, endpoint + params);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = body['results'] as List<dynamic>;
        return list.map((value) => Specie.fromMap(value)).toList();
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

  Future<Species> getSpeciesByPage(Client client, {String? param}) async {
    const endpoint = 'species';
    final params = '?$param';
    final url = baseUrl + endpoint + params;

    try {
      var response = await callGet(client, endpoint + params);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = Species.fromMap(body, url);

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
