import 'package:http/http.dart';

class SwapiApi {
  final String _baseUrl = 'https://swapi.dev/api/';

  String get baseUrl => _baseUrl;

  final Map<String, String> _headers = {'Content-type': 'application/json'};

  Future<Response> callGet(Client client, String path) async {
    final url = Uri.parse(path.contains('http') ? path : _baseUrl + path);
    final response = await client.get(url, headers: _headers);
    return response;
  }
}
