import 'package:project_starwars/app/models/category_model.dart';
import 'package:project_starwars/app/services/swapi_rest/index.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

import '../exceptions/api_exceptions.dart';
import '../models/adapter/category_adapter.dart';
import '../services/bing_rest/bing_service.dart';

class CategoryController with ChangeNotifier {
  final CategoryService service;
  final BingRepository bingRepository;
  final Client _client = Client();

  CategoryController({required this.service, required this.bingRepository});

  Category? _category;
  Category? get category => _category;

  Future<void> getDataByPage({required String category, String? page}) async {
    var cache = await Hive.openBox('my_swapi');

    try {
      // Criar a chave única combinando categoria e página
      var uniqueKey = '$category$page';

      var storedCategoryAdapter = cache.get(uniqueKey) as CategoryAdapter?;

      // Validando se há cache
      if (storedCategoryAdapter != null &&
          storedCategoryAdapter.name != null &&
          storedCategoryAdapter.name == uniqueKey) {
        var cachedCategory = storedCategoryAdapter.toCategory();

        // Verificar se o cache é recente (menos de 1 hora)
        var lastUpdated = cache.get('lastUpdated$uniqueKey');
        if (lastUpdated != null &&
            DateTime.now().difference(lastUpdated) < const Duration(hours: 1)) {
          // Usar a categoria do cache
          _category = cachedCategory;
          notifyListeners();
          return;
        }
      }
      // Obter dados da API se não estiver em cache ou o cache estiver desatualizado
      _category = await service.getDataByPage(_client,
          param: page, category: category.toLowerCase());

      if (_category!.next != null && _category!.next!.contains('page')) {
        // Tratando os valores de next e previous
        var formatedNextPage = _category!.next.toString().split('=');
        var formatedPreviousPage = _category!.previous.toString().split('=');
        var formatedCurrentPage = _category!.current.toString().split('=');

        _category!.current = formatedCurrentPage[1];
        _category!.next = formatedNextPage[1];
        _category!.previous = formatedPreviousPage[1];
      } else {
        _category!.next = '0';
        _category!.previous = '0';
        _category!.current = '0';
      }
      // Buscando imagens e atribuindo a detalhes da categoria
      await _attributeImageToCategory(_category!.detail!);

      // Salvar dados no Hive
      var categoryAdapter = CategoryAdapter.fromCategory(_category!, uniqueKey);
      cache.put(uniqueKey, categoryAdapter);
      // Salvar data da última atualização
      cache.put('lastUpdated$uniqueKey', DateTime.now());
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> _attributeImageToCategory(List<Detail> list) async {
    List<Detail> updatedList = [];
    for (var detail in list) {
      var resultBing =
          await bingRepository.getImageByBing(_client, param: detail.name);
      var updateDetail = detail;
      updateDetail.image = resultBing.first.thumbnailUrl;
      updatedList.add(updateDetail);
    }
    _category!.detail = updatedList;
    notifyListeners();
  }

  Future<void> searchData(
      {required String? category, required String value}) async {
    try {
      _category =
          await service.searchData(_client, category: category, value: value);

      await _attributeImageToCategory(_category!.detail!);

      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }
}
