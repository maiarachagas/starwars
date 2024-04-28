import 'dart:convert';

import 'package:http/http.dart';

import '../../exceptions/api_exceptions.dart';
import '../../models/index.dart';
import 'swapi_api.dart';

class VehiclesService extends SwapiApi {
  Future<List<Vehicle>> getVehicles(Client client) async {
    const endpoint = 'vehicles';

    try {
      var response = await callGet(client, endpoint);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = body['results'] as List<dynamic>;

        return list.map((value) => Vehicle.fromMap(value)).toList();
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

  Future<List<Vehicle>> searchVehicle(Client client,
      {required String value}) async {
    const endpoint = 'vehicles';
    final params = '?search=$value';

    try {
      var response = await callGet(client, endpoint + params);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = body['results'] as List<dynamic>;
        return list.map((value) => Vehicle.fromMap(value)).toList();
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

  Future<Vehicles> getVehiclesByPage(Client client, {String? param}) async {
    const endpoint = 'vehicles';
    final params = '?$param';
    final url = baseUrl + endpoint + params;

    try {
      var response = await callGet(client, endpoint + params);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var list = Vehicles.fromMap(body, url);

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

  Future<Vehicle> getVehicleById(Client client, {required String url}) async {
    try {
      var response = await callGet(client, url);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var vehicles = Vehicle.fromMap(body);

        // Buscar informações adicionais sobre os filmes
        var films = vehicles.films;
        for (var filmUrl in films!) {
          var response = await callGet(client, filmUrl);
          if (response.statusCode == 200) {
            var filmData = jsonDecode(response.body);
            var film = Film.fromMap(filmData);
            vehicles.addFilm(film);
          }
        }

        // Buscar informações adicionais sobre as personagens
        var peoples = vehicles.pilots;
        for (var url in peoples!) {
          var response = await callGet(client, url);
          if (response.statusCode == 200) {
            var peoplesData = jsonDecode(response.body);
            var people = Personage.fromMap(peoplesData);
            vehicles.addPeople(people);
          }
        }

        return vehicles;
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
