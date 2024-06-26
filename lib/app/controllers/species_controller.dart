import 'package:project_starwars/app/models/species_model.dart';
import 'package:project_starwars/app/services/swapi_rest/index.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../exceptions/api_exceptions.dart';
import '../services/bing_rest/bing_service.dart';

class SpeciesController with ChangeNotifier {
  final SpeciesService service;
  final BingRepository bingRepository;

  SpeciesController({required this.service, required this.bingRepository});

  final Client _client = Client();

  List<Specie>? _specie;
  Species? _species;
  Specie? _specieDetail;

  List<Specie>? get specie => _specie;
  Species? get species => _species;
  Specie? get specieDetail => _specieDetail;

  int totalPage = 0;
  int nextPage = 0;
  int previousPage = 0;
  int current = 0;

  Future<void> getSpecies() async {
    try {
      _specie = await service.getSpecies(_client);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> searchSpecie({required String value}) async {
    try {
      _specie = await service.searchSpecie(_client, value: value);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> getSpeciesByPage({String? page}) async {
    try {
      _species = await service.getSpeciesByPage(_client, param: page);

      if (_species!.next!.contains('page')) {
        var formatedNextPage = _species!.next.toString().split('=');
        var formatedPreviousPage = _species!.previous.toString().split('=');
        var formatedCurrentPage = _species!.current.toString().split('=');

        current = int.parse(formatedCurrentPage[1]);
        nextPage = int.parse(formatedNextPage[1]);
        previousPage = int.parse(formatedPreviousPage[1]);
        totalPage = _species!.count!;
      }

      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> fetchSpecies() async {
    try {
      _specie = _species!.specie;
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> attributeImageToSpecie(List<Specie> list) async {
    List<Specie> updatedSpecies = [];

    for (var specie in list) {
      var resultBing =
          await bingRepository.getImageByBing(_client, param: specie.name);
      var updatedSpecie = specie;

      if (resultBing.isNotEmpty) {
        updatedSpecie.thumbnailUrl = resultBing.first.thumbnailUrl;
      }

      updatedSpecies.add(updatedSpecie);
    }
    _specie = updatedSpecies;
    notifyListeners();
  }

  Future<void> getSpecieById(
      {required String endpoint, required String image}) async {
    try {
      _specieDetail = await service.getSpecieById(_client, url: endpoint);
      _specieDetail!.thumbnailUrl = image;
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  void clearList() {
    _specie = [];
    notifyListeners();
  }
}
