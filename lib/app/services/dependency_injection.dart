import 'package:app_teste_unitario/app/repositories/bing_repository.dart';
import 'package:app_teste_unitario/app/repositories/swapi_repository.dart';
import 'package:get_it/get_it.dart';

GetIt injector = GetIt.instance;

class DependencyInjection {
  static Future<void> inject({dynamic mockDependency}) async {
    injector.registerSingleton<SwapiRepository>(SwapiRepository());

    injector.registerSingleton<BingRepository>(BingRepository());
  }
}
