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

  List<Personages>? _personages;
  List<Personages>? _resultSearchPersonages;
  AllPersonages? _allPersonages;

  List<Personages>? get personages => _personages;
  List<Personages>? get resultSearch => _resultSearchPersonages;
  AllPersonages? get allPersonages => _allPersonages;
  int totalPage = 0;
  int nextPage = 0;
  int previousPage = 0;
  int current = 0;

  Future<void> getPersonages() async {
    try {
      _personages = await repository.getPersonages(_client);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> searchPersonages({required String value}) async {
    try {
      _resultSearchPersonages =
          await repository.searchPersonages(_client, value: value);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> getPersonagesByPage({String? page}) async {
    try {
      _allPersonages =
          await repository.getPersonagesByPage(_client, param: page);

      if (_allPersonages!.next!.contains('page')) {
        var formatedNextPage = _allPersonages!.next.toString().split('=');
        var formatedPreviousPage =
            _allPersonages!.previous.toString().split('=');
        var formatedCurrentPage = _allPersonages!.current.toString().split('=');

        current = int.parse(formatedCurrentPage[1]);
        nextPage = int.parse(formatedNextPage[1]);
        previousPage = int.parse(formatedPreviousPage[1]);
        totalPage = _allPersonages!.count!;
      }

      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> fetchPersonages() async {
    try {
      _personages = _allPersonages!.personages;
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> attributeImageToPerson(List<Personages> list) async {
    List<Personages> updatedPersonages = [];

    for (var person in list) {
      var resultBing =
          await bingRepository.getImageByBing(_client, param: person.name);
      var updatedPersonage = person;

      updatedPersonage.thumbnailUrl = resultBing.first.thumbnailUrl;
      updatedPersonages.add(updatedPersonage);
    }
    _personages = updatedPersonages;
    notifyListeners();
  }

  void clearSearch() {
    _resultSearchPersonages = [];
    notifyListeners();
  }

  void clearList() {
    _personages = [];
    notifyListeners();
  }
}
