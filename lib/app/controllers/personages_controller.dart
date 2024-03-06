import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../exceptions/api_exceptions.dart';
import '../models/personages_model.dart';
import '../services/bing_rest/bing_service.dart';
import '../services/swapi_rest/index.dart';

class PersonagesController with ChangeNotifier {
  final PersonagesService repository;
  final BingRepository bingRepository;

  PersonagesController(
      {required this.repository, required this.bingRepository});

  final Client _client = Client();

  List<Personage>? _personage;
  Personages? _personages;
  Personage? _personageDetail;

  List<Personage>? get personage => _personage;
  Personages? get personages => _personages;
  Personage? get personageDetail => _personageDetail;

  int totalPage = 0;
  int nextPage = 0;
  int previousPage = 0;
  int current = 0;

  Future<void> getPersonages() async {
    try {
      _personage = await repository.getPersonages(_client);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> searchPersonages({required String value}) async {
    try {
      _personage = await repository.searchPersonages(_client, value: value);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> getPersonagesByPage({String? page}) async {
    try {
      _personages = await repository.getPersonagesByPage(_client, param: page);

      if (_personages!.next!.contains('page')) {
        var formatedNextPage = _personages!.next.toString().split('=');
        var formatedPreviousPage = _personages!.previous.toString().split('=');
        var formatedCurrentPage = _personages!.current.toString().split('=');

        current = int.parse(formatedCurrentPage[1]);
        nextPage = int.parse(formatedNextPage[1]);
        previousPage = int.parse(formatedPreviousPage[1]);
        totalPage = _personages!.count!;
      }

      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> fetchPersonages() async {
    try {
      _personage = _personages!.personage;
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> attributeImageToPerson(List<Personage> list) async {
    List<Personage> updatedPersonages = [];

    for (var person in list) {
      var resultBing =
          await bingRepository.getImageByBing(_client, param: person.name);
      var updatedPersonage = person;

      updatedPersonage.thumbnailUrl = resultBing.first.thumbnailUrl;
      updatedPersonages.add(updatedPersonage);
    }
    _personage = updatedPersonages;
    notifyListeners();
  }

  Future<void> getPersonageById(
      {required String endpoint, required String image}) async {
    try {
      _personageDetail =
          await repository.getPersonageById(_client, url: endpoint);
      _personageDetail!.thumbnailUrl = image;
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  void clearList() {
    _personage = [];
    notifyListeners();
  }
}
