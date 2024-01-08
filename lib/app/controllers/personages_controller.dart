import 'package:app_teste_unitario/app/models/personages_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../exceptions/api_exceptions.dart';
import '../repositories/swapi_repository.dart';

class PersonagesController with ChangeNotifier {
  final Client _client = Client();

  late final _repository = SwapiRepository();
  List<Personages>? _personages;
  List<Personages>? _resultSearchPersonages;
  AllPersonages? _allPersonages;

  List<Personages>? get personages => _personages;
  List<Personages>? get resultSearch => _resultSearchPersonages;
  AllPersonages? get allPersonages => _allPersonages;

  Future<void> getPersonages() async {
    try {
      _personages = await _repository.getPersonages(_client);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> searchPersonages({required String value}) async {
    try {
      _resultSearchPersonages =
          await _repository.searchPersonages(_client, value: value);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> getPersonagesByPage({String? page}) async {
    try {
      _allPersonages =
          await _repository.getPersonagesByPage(_client, page: page);
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

  void clearSearch() {
    _resultSearchPersonages = [];
    notifyListeners();
  }

  void clearList() {
    _personages = [];
    notifyListeners();
  }
}
