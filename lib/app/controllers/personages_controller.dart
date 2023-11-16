import 'package:app_teste_unitario/app/models/personages_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../exceptions/api_exceptions.dart';
import '../repositories/swapi_repository.dart';

class PersonagesController with ChangeNotifier {
  final Client _client = Client();

  late final _repository = SwapiRepository();
  List<Personages>? _list;
  List<Personages>? _resultSearch;

  List<Personages>? get list => _list;
  List<Personages>? get resultSearch => _resultSearch;

  Future<void> getAllPersonages() async {
    try {
      _list = await _repository.getAllPersonages(_client);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> searchPersonages({required String value}) async {
    try {
      _resultSearch = await _repository.searchPersonages(_client, value: value);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  void clearSearch() {
    _resultSearch = [];
    notifyListeners();
  }

  void clearList() {
    _list = [];
    notifyListeners();
  }
}
