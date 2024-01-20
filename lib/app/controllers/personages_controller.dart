import 'package:app_teste_unitario/app/models/personages_model.dart';
import 'package:app_teste_unitario/app/repositories/bing_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../exceptions/api_exceptions.dart';
import '../repositories/swapi_repository.dart';

class PersonagesController with ChangeNotifier {
  final SwapiRepository repository;
  final BingRepository bingRepository;

  PersonagesController(
      {required this.repository, required this.bingRepository});

  final Client _client = Client();

  List<Personage>? _personage;
  Personages? _personages;

  List<Personage>? get personage => _personage;
  Personages? get personages => _personages;
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

  void clearList() {
    _personage = [];
    notifyListeners();
  }
}
