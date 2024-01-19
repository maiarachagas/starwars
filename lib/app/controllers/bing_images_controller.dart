import 'package:app_teste_unitario/app/repositories/bing_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import '../models/bing_model.dart';
import '../models/personages_model.dart';

class BingImagesController with ChangeNotifier {
  final BingRepository _repository;

  BingImagesController({required BingRepository repository})
      : _repository = repository;
  final Client _client = Client();

  List<InfoImage>? _image;
  List imagePerson = [];

  List<InfoImage>? get image => _image;

  Future<void> getImageByBing({String? name}) async {
    _image = await _repository.getImageByBing(_client, param: name);

    notifyListeners();
  }

  Future<void> attributeImageToPerson(List<Personages> personages) async {
    for (var person in personages) {
      await getImageByBing(name: person.name);
      imagePerson
          .add({'name': person.name, 'image': _image!.first.thumbnailUrl});
    }
    notifyListeners();
  }
}
