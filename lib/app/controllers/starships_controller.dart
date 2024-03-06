import 'package:project_starwars/app/services/swapi_rest/index.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../exceptions/api_exceptions.dart';
import '../models/starships_model.dart';
import '../services/bing_rest/bing_service.dart';

class StarshipsController with ChangeNotifier {
  final StarshipsService service;
  final BingRepository bingRepository;

  StarshipsController({required this.service, required this.bingRepository});

  final Client _client = Client();

  List<Starship>? _starship;
  Starships? _starships;
  Starship? _starshipDetail;

  List<Starship>? get starship => _starship;
  Starships? get starships => _starships;
  Starship? get starshipDetail => _starshipDetail;
  int totalPage = 0;
  int nextPage = 0;
  int previousPage = 0;
  int current = 0;

  Future<void> getStarships() async {
    try {
      _starship = await service.getStarships(_client);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> searchStarship({required String value}) async {
    try {
      _starship = await service.searchStarship(_client, value: value);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> getStarshipsByPage({String? page}) async {
    try {
      _starships = await service.getStarshipsByPage(_client, param: page);

      if (_starships!.next!.contains('page')) {
        var formatedNextPage = _starships!.next.toString().split('=');
        var formatedPreviousPage = _starships!.previous.toString().split('=');
        var formatedCurrentPage = _starships!.current.toString().split('=');

        current = int.parse(formatedCurrentPage[1]);
        nextPage = int.parse(formatedNextPage[1]);
        previousPage = int.parse(formatedPreviousPage[1]);
        totalPage = _starships!.count!;
      }

      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> fetchStarships() async {
    try {
      _starship = _starships!.starship;
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> attributeImageToStarship(List<Starship> list) async {
    List<Starship> updatedStarships = [];

    for (var starship in list) {
      var resultBing =
          await bingRepository.getImageByBing(_client, param: starship.name);
      var updatedStarship = starship;

      updatedStarship.thumbnailUrl = resultBing.first.thumbnailUrl;
      updatedStarships.add(updatedStarship);
    }
    _starship = updatedStarships;
    notifyListeners();
  }

  Future<void> getStarshipById(
      {required String endpoint, required String image}) async {
    try {
      _starshipDetail = await service.getStarshipById(_client, url: endpoint);
      _starshipDetail!.thumbnailUrl = image;
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  void clearList() {
    _starship = [];
    notifyListeners();
  }
}
