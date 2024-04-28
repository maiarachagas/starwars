import 'dart:convert';

import 'package:http/http.dart';

import '../../exceptions/api_exceptions.dart';
import '../../models/index.dart';
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

  Future<Specie> getSpecieById(Client client, {required String url}) async {
    try {
      var response = await callGet(client, url);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var specie = Specie.fromMap(body);

        // Buscar informações adicionais sobre os filmes
        var films = specie.films;
        for (var filmUrl in films!) {
          var response = await callGet(client, filmUrl);
          if (response.statusCode == 200) {
            var filmData = jsonDecode(response.body);
            var film = Film.fromMap(filmData);
            specie.addFilm(film);
          }
        }

        // Buscar informações adicionais sobre as personagens
        var peoples = specie.people;
        for (var url in peoples!) {
          var response = await callGet(client, url);
          if (response.statusCode == 200) {
            var peoplesData = jsonDecode(response.body);
            var people = Personage.fromMap(peoplesData);
            specie.addPeople(people);
          }
        }

        // Buscar informações adicionais sobre as planet
        var responsePlanet = await callGet(client, specie.homeworld!);
        if (responsePlanet.statusCode == 200) {
          var planetData = jsonDecode(responsePlanet.body);
          var planet = Planet.fromMap(planetData);
          specie.addPlanet(planet);
        }

        return specie;
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
