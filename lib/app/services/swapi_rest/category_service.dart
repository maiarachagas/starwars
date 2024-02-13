import 'dart:convert';

import 'package:http/http.dart';

import '../../exceptions/api_exceptions.dart';
import '../../models/category_model.dart';
import 'swapi_api.dart';

class CategoryService extends SwapiApi {
  Future<Category> getDataByPage(Client client,
      {String? category, String? param}) async {
    final params = '?page=$param';
    final url = baseUrl + category! + params;

    try {
      var response = await callGet(client, category + params);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var result = Category.fromMap(body, url);
        return result;
      } else {
        throw ApiException(
            message: 'Erro na requisição',
            code: response.statusCode.toString(),
            details: '${DateTime.now()} - ${response.body}');
      }
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }
}
