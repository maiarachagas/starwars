import 'package:app_teste_unitario/app/services/swapi_rest/category_service.dart';
import 'package:app_teste_unitario/app/services/swapi_rest/films_service.dart';
import 'package:app_teste_unitario/app/services/swapi_rest/personages_service.dart';
import 'package:app_teste_unitario/app/services/swapi_rest/planets_service.dart';
import 'package:app_teste_unitario/app/services/swapi_rest/species_service.dart';
import 'package:app_teste_unitario/app/services/swapi_rest/starships_service.dart';
import 'package:app_teste_unitario/app/services/swapi_rest/vehicles_service.dart';
import 'package:get_it/get_it.dart';

import 'bing_rest/bing_service.dart';

GetIt injector = GetIt.instance;

class DependencyInjection {
  static Future<void> inject({dynamic mockDependency}) async {
    injector.registerSingleton<PersonagesService>(PersonagesService());

    injector.registerSingleton<FilmsService>(FilmsService());

    injector.registerSingleton<PlanetsService>(PlanetsService());

    injector.registerSingleton<SpeciesService>(SpeciesService());

    injector.registerSingleton<StarshipsService>(StarshipsService());

    injector.registerSingleton<VehiclesService>(VehiclesService());

    injector.registerSingleton<BingRepository>(BingRepository());

    injector.registerSingleton<CategoryService>(CategoryService());
  }
}
