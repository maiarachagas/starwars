import 'package:project_starwars/app/models/vehicles_model.dart';
import 'package:project_starwars/app/services/swapi_rest/index.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../exceptions/api_exceptions.dart';
import '../services/bing_rest/bing_service.dart';

class VehiclesController with ChangeNotifier {
  final VehiclesService service;
  final BingRepository bingRepository;

  VehiclesController({required this.service, required this.bingRepository});

  final Client _client = Client();

  List<Vehicle>? _vehicle;
  Vehicles? _vehicles;
  Vehicle? _vehicleDetail;

  List<Vehicle>? get vehicle => _vehicle;
  Vehicles? get vehicles => _vehicles;
  Vehicle? get vehicleDetail => _vehicleDetail;

  int totalPage = 0;
  int nextPage = 0;
  int previousPage = 0;
  int current = 0;

  Future<void> getVehicles() async {
    try {
      _vehicle = await service.getVehicles(_client);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> searchVehicle({required String value}) async {
    try {
      _vehicle = await service.searchVehicle(_client, value: value);
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> getVehiclesByPage({String? page}) async {
    try {
      _vehicles = await service.getVehiclesByPage(_client, param: page);

      if (_vehicles!.next!.contains('page')) {
        var formatedNextPage = _vehicles!.next.toString().split('=');
        var formatedPreviousPage = _vehicles!.previous.toString().split('=');
        var formatedCurrentPage = _vehicles!.current.toString().split('=');

        current = int.parse(formatedCurrentPage[1]);
        nextPage = int.parse(formatedNextPage[1]);
        previousPage = int.parse(formatedPreviousPage[1]);
        totalPage = _vehicles!.count!;
      }

      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> fetchVehicles() async {
    try {
      _vehicle = _vehicles!.vehicle;
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  Future<void> attributeImageToVehicle(List<Vehicle> list) async {
    List<Vehicle> updatedVehicles = [];

    for (var vehicle in list) {
      var resultBing =
          await bingRepository.getImageByBing(_client, param: vehicle.name);
      var updatedVehicle = vehicle;

      if (resultBing.isNotEmpty) {
        updatedVehicle.thumbnailUrl = resultBing.first.thumbnailUrl;
      }

      updatedVehicles.add(updatedVehicle);
    }
    _vehicle = updatedVehicles;
    notifyListeners();
  }

  Future<void> getVehicleById(
      {required String endpoint, required String image}) async {
    try {
      _vehicleDetail = await service.getVehicleById(_client, url: endpoint);
      _vehicleDetail!.thumbnailUrl = image;
      notifyListeners();
    } catch (e) {
      throw ApiException(
          message: '$e', code: '1000', details: DateTime.now().toString());
    }
  }

  void clearList() {
    _vehicle = [];
    notifyListeners();
  }
}
