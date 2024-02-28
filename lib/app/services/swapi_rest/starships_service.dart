import 'package:app_teste_unitario/app/services/swapi_rest/swapi_api.dart';
import 'dart:convert';

import 'package:http/http.dart';

import '../../exceptions/api_exceptions.dart';
import '../../models/index.dart';
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

  Future<Starship> getStarshipById(Client client, {required String url}) async {
    try {
      var response = await callGet(client, url);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var starships = Starship.fromMap(body);

        // Buscar informações adicionais sobre os filmes
        var films = starships.films;
        for (var filmUrl in films!) {
          var response = await callGet(client, filmUrl);
          if (response.statusCode == 200) {
            var filmData = jsonDecode(response.body);
            var film = Film.fromMap(filmData);
            starships.addFilm(film);
          }
        }

        // Buscar informações adicionais sobre as personagens
        var peoples = starships.pilots;
        for (var url in peoples!) {
          var response = await callGet(client, url);
          if (response.statusCode == 200) {
            var peoplesData = jsonDecode(response.body);
            var people = Personage.fromMap(peoplesData);
            starships.addPeople(people);
          }
        }

        return starships;
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
