import 'package:app_teste_unitario/app/models/personages_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../exceptions/api_exceptions.dart';
import '../repositories/swapi_repository.dart';

class PersonagesController with ChangeNotifier {
  final Client _client;

  PersonagesController(this._client);

  late final SwapiRepository _repository;
  List<Personages>? _list;
  List<Personages>? _result;

  List<Personages>? get list => _list;
  List<Personages>? get result => _result;

  void initializeRepository() {
    _repository = SwapiRepository(_client);
  }

  Future<void> getAllPersonages() async {
    try {
      _list = await _repository.getAllPersonages();
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> searchPersonages({required String value}) async {
    try {
      _result = await _repository.searchPersonages(value: value);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  void clearSearch() {
    _result = [];
    notifyListeners();
  }

  void clearList() {
    _list = [];
    notifyListeners();
  }
}
