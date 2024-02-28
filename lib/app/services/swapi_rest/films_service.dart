import 'dart:convert';

import 'package:http/http.dart';

import '../../exceptions/api_exceptions.dart';
import '../../models/index.dart';
import 'swapi_api.dart';

class FilmsService extends SwapiApi {
  Future<List<Film>> getFilms(Client client) async {
    const endpoint = 'films';

    try {
      var response = await callGet(client, endpoint);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = body['results'] as List<dynamic>;

        return list.map((value) => Film.fromMap(value)).toList();
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

  Future<List<Film>> searchFilms(Client client, {required String value}) async {
    const endpoint = 'films';
    final params = '?search=$value';

    try {
      var response = await callGet(client, endpoint + params);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = body['results'] as List<dynamic>;
        return list.map((value) => Film.fromMap(value)).toList();
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

  Future<Film> getFilmsById(Client client, {required String url}) async {
    try {
      var response = await callGet(client, url);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var film = Film.fromMap(body);

        // Buscar informações adicionais sobre as personagens
        var peoples = film.characters;
        for (var url in peoples!) {
          var response = await callGet(client, url);
          if (response.statusCode == 200) {
            var peopleData = jsonDecode(response.body);
            var people = Personage.fromMap(peopleData);
            film.addPeople(people);
          }
        }

        // Buscar informações adicionais sobre as starships
        var starships = film.starships;
        for (var url in starships!) {
          var response = await callGet(client, url);
          if (response.statusCode == 200) {
            var starshipData = jsonDecode(response.body);
            var starship = Starship.fromMap(starshipData);
            film.addStarship(starship);
          }
        }

        // Buscar informações adicionais sobre as vehicles
        var vehicles = film.vehicles;
        for (var url in vehicles!) {
          var response = await callGet(client, url);
          if (response.statusCode == 200) {
            var vehicleData = jsonDecode(response.body);
            var vehicle = Vehicle.fromMap(vehicleData);
            film.addVehicle(vehicle);
          }
        }

        // Buscar informações adicionais sobre as species
        var species = film.species;
        for (var url in species!) {
          var response = await callGet(client, url);
          if (response.statusCode == 200) {
            var speciesData = jsonDecode(response.body);
            var species = Specie.fromMap(speciesData);
            film.addSpecie(species);
          }
        }

        // Buscar informações adicionais sobre as planet
        var planets = film.planets;
        for (var url in planets!) {
          var response = await callGet(client, url);
          if (response.statusCode == 200) {
            var planetsData = jsonDecode(response.body);
            var planet = Planet.fromMap(planetsData);
            film.addPlanet(planet);
          }
        }

        return film;
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
