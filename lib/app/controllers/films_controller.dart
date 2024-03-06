import 'package:project_starwars/app/models/films_model.dart';
import 'package:project_starwars/app/services/swapi_rest/index.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../exceptions/api_exceptions.dart';
import '../services/bing_rest/bing_service.dart';

class FilmsController with ChangeNotifier {
  final FilmsService service;
  final BingRepository bingRepository;

  FilmsController({required this.service, required this.bingRepository});

  final Client _client = Client();

  List<Film>? _film;
  Films? _films;
  Film? _filmDetail;

  List<Film>? get film => _film;
  Films? get films => _films;
  Film? get filmDetail => _filmDetail;
  int totalPage = 0;
  int nextPage = 0;
  int previousPage = 0;
  int current = 0;

  Future<void> getFilms() async {
    try {
      _film = await service.getFilms(_client);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> searchFilms({required String value}) async {
    try {
      _film = await service.searchFilms(_client, value: value);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> fetchFilms() async {
    try {
      _film = _films!.film;
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> attributeImageToFilm(List<Film> list) async {
    List<Film> updatedFilms = [];

    for (var film in list) {
      var resultBing =
          await bingRepository.getImageByBing(_client, param: film.title);
      var updatedFilm = film;

      updatedFilm.thumbnailUrl = resultBing.first.thumbnailUrl;
      updatedFilms.add(updatedFilm);
    }
    _film = updatedFilms;
    notifyListeners();
  }

  Future<void> getFilmsById(
      {required String endpoint, required String image}) async {
    try {
      _filmDetail = await service.getFilmsById(_client, url: endpoint);
      _filmDetail!.thumbnailUrl = image;
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  void clearList() {
    _film = [];
    notifyListeners();
  }
}
