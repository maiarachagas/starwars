import 'package:app_teste_unitario/app/models/category_model.dart';
import 'package:app_teste_unitario/app/services/swapi_rest/category_service.dart';
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

  int totalPage = 0;
  int nextPage = 0;
  int previousPage = 0;
  int current = 0;

  Future<void> getDataByPage({required String category, String? page}) async {
    var cache = await Hive.openBox('my_swapi');

    try {
      var storedCategoryAdapter = cache.get(category) as CategoryAdapter?;

      // Validando se há cache
      if (storedCategoryAdapter != null &&
          storedCategoryAdapter.name != null &&
          storedCategoryAdapter.name == category.toLowerCase()) {
        var cachedCategory = storedCategoryAdapter.toCategory();

        // Verificar se o cache é recente (menos de 1 hora)
        var lastUpdated = cache.get('lastUpdated');
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

        current = int.parse(formatedCurrentPage[1]);
        nextPage = int.parse(formatedNextPage[1]);
        previousPage = int.parse(formatedPreviousPage[1]);
        totalPage = _category!.count!;
      } else {
        totalPage = 0;
        nextPage = 0;
        previousPage = 0;
        current = 0;
      }
      // Buscando imagens e atribuindo a detalhes da categoria
      await _attributeImageToCategory(_category!.detail!);

      // Salvar dados no Hive
      var categoryAdapter = CategoryAdapter.fromCategory(_category!, category);
      cache.put(category, categoryAdapter);
      // Salvar data da última atualização
      cache.put('lastUpdated', DateTime.now());
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
}
