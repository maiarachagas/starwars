import 'dart:convert';

import 'package:http/http.dart';

import '../../exceptions/api_exceptions.dart';
import '../../models/index.dart';
import 'swapi_api.dart';

class PlanetsService extends SwapiApi {
  Future<List<Planet>> getPlanets(Client client) async {
    const endpoint = 'planets';

    try {
      var response = await callGet(client, endpoint);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = body['results'] as List<dynamic>;

        return list.map((value) => Planet.fromMap(value)).toList();
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

  Future<List<Planet>> searchPlanet(Client client,
      {required String value}) async {
    const endpoint = 'planets';
    final params = '?search=$value';

    try {
      var response = await callGet(client, endpoint + params);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = body['results'] as List<dynamic>;
        return list.map((value) => Planet.fromMap(value)).toList();
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

  Future<Planets> getPlanetsByPage(Client client, {String? param}) async {
    const endpoint = 'planets';
    final params = '?$param';
    final url = baseUrl + endpoint + params;

    try {
      var response = await callGet(client, endpoint + params);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = Planets.fromMap(body, url);

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

  Future<Planet> getPlanetById(Client client, {required String url}) async {
    try {
      var response = await callGet(client, url);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var planet = Planet.fromMap(body);

        // Buscar informações adicionais sobre os filmes
        var films = planet.films;
        for (var filmUrl in films!) {
          var response = await callGet(client, filmUrl);
          if (response.statusCode == 200) {
            var filmData = jsonDecode(response.body);
            var film = Film.fromMap(filmData);
            planet.addFilm(film);
          }
        }

        // Buscar informações adicionais sobre as personagens
        var residents = planet.residents;
        for (var url in residents!) {
          var response = await callGet(client, url);
          if (response.statusCode == 200) {
            var residentData = jsonDecode(response.body);
            var resident = Personage.fromMap(residentData);
            planet.addResident(resident);
          }
        }

        return planet;
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
