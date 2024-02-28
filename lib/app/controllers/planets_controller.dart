import 'package:app_teste_unitario/app/models/planets_model.dart';
import 'package:app_teste_unitario/app/services/swapi_rest/index.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../exceptions/api_exceptions.dart';
import '../services/bing_rest/bing_service.dart';

class PlanetsController with ChangeNotifier {
  final PlanetsService service;
  final BingRepository bingRepository;

  PlanetsController({required this.service, required this.bingRepository});

  final Client _client = Client();

  List<Planet>? _planet;
  Planets? _planets;
  Planet? _planetDetail;

  List<Planet>? get planet => _planet;
  Planets? get planets => _planets;
  Planet? get planetDetail => _planetDetail;

  int totalPage = 0;
  int nextPage = 0;
  int previousPage = 0;
  int current = 0;

  Future<void> getPlanets() async {
    try {
      _planet = await service.getPlanets(_client);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> searchPlanet({required String value}) async {
    try {
      _planet = await service.searchPlanet(_client, value: value);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> getPlanetsByPage({String? page}) async {
    try {
      _planets = await service.getPlanetsByPage(_client, param: page);

      if (_planets!.next!.contains('page')) {
        var formatedNextPage = _planets!.next.toString().split('=');
        var formatedPreviousPage = _planets!.previous.toString().split('=');
        var formatedCurrentPage = _planets!.current.toString().split('=');

        current = int.parse(formatedCurrentPage[1]);
        nextPage = int.parse(formatedNextPage[1]);
        previousPage = int.parse(formatedPreviousPage[1]);
        totalPage = _planets!.count!;
      }

      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> fetchPlanets() async {
    try {
      _planet = _planets!.planet;
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> attributeImageToPlanet(List<Planet> list) async {
    List<Planet> updatedPlanets = [];

    for (var planet in list) {
      var resultBing =
          await bingRepository.getImageByBing(_client, param: planet.name);
      var updatedPlanet = planet;

      updatedPlanet.thumbnailUrl = resultBing.first.thumbnailUrl;
      updatedPlanets.add(updatedPlanet);
    }
    _planet = updatedPlanets;
    notifyListeners();
  }

  Future<void> getPlanetById(
      {required String endpoint, required String image}) async {
    try {
      _planetDetail = await service.getPlanetById(_client, url: endpoint);
      _planetDetail!.thumbnailUrl = image;
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  void clearList() {
    _planet = [];
    notifyListeners();
  }
}
