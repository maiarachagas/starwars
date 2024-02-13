import 'package:app_teste_unitario/app/models/category_model.dart';
import 'package:app_teste_unitario/app/services/swapi_rest/category_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../exceptions/api_exceptions.dart';
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
    try {
      _category = await service.getDataByPage(_client,
          param: page, category: category.toLowerCase());

      if (_category!.next != null && _category!.next!.contains('page')) {
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
      //_attributeImageToPerson(_category!.detail!);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> _attributeImageToPerson(List<Detail> list) async {
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
