import 'dart:convert';

import 'package:http/http.dart';

import '../../exceptions/api_exceptions.dart';
import '../../models/index.dart';
import 'swapi_api.dart';

class PersonagesService extends SwapiApi {
  Future<List<Personage>> getPersonages(Client client) async {
    const endpoint = 'people';

    try {
      var response = await callGet(client, endpoint);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = body['results'] as List<dynamic>;

        return list.map((value) => Personage.fromMap(value)).toList();
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

  Future<List<Personage>> searchPersonages(Client client,
      {required String value}) async {
    const endpoint = 'people';
    final params = '?search=$value';

    try {
      var response = await callGet(client, endpoint + params);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = body['results'] as List<dynamic>;
        return list.map((value) => Personage.fromMap(value)).toList();
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

  Future<Personages> getPersonagesByPage(Client client, {String? param}) async {
    const endpoint = 'people';
    final params = '?$param';
    final url = baseUrl + endpoint + params;

    try {
      var response = await callGet(client, endpoint + params);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = Personages.fromMap(body, url);

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

  Future<Personage> getPersonageById(Client client,
      {required String url}) async {
    try {
      var response = await callGet(client, url);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var personage = Personage.fromMap(body);

        // Buscar informações adicionais sobre os filmes
        var films = personage.films;
        for (var filmUrl in films!) {
          var response = await callGet(client, filmUrl);
          if (response.statusCode == 200) {
            var filmData = jsonDecode(response.body);
            var film = Film.fromMap(filmData);
            personage.addFilm(film);
          }
        }

        // Buscar informações adicionais sobre as starships
        var starships = personage.starships;
        for (var starshipUrl in starships!) {
          var response = await callGet(client, starshipUrl);
          if (response.statusCode == 200) {
            var starshipData = jsonDecode(response.body);
            var starship = Starship.fromMap(starshipData);
            personage.addStarship(starship);
          }
        }

        // Buscar informações adicionais sobre as vehicles
        var vehicles = personage.vehicles;
        for (var vehicleUrl in vehicles!) {
          var response = await callGet(client, vehicleUrl);
          if (response.statusCode == 200) {
            var vehicleData = jsonDecode(response.body);
            var vehicle = Vehicle.fromMap(vehicleData);
            personage.addVehicle(vehicle);
          }
        }

        // Buscar informações adicionais sobre as species
        var species = personage.species;
        for (var specieUrl in species!) {
          var response = await callGet(client, specieUrl);
          if (response.statusCode == 200) {
            var speciesData = jsonDecode(response.body);
            var species = Specie.fromMap(speciesData);
            personage.addSpecie(species);
          }
        }

        // Buscar informações adicionais sobre as planet
        var responsePlanet = await callGet(client, personage.homeworld!);
        if (responsePlanet.statusCode == 200) {
          var planetData = jsonDecode(responsePlanet.body);
          var planet = Planet.fromMap(planetData);
          personage.addPlanet(planet);
        }

        return personage;
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
