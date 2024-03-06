import 'package:app_teste_unitario/app/controllers/index.dart';
import 'package:app_teste_unitario/app/services/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/commons/custom_color.dart';
import 'app/services/bing_rest/bing_service.dart';
import 'app/services/swapi_rest/index.dart';
import 'app/views/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PersonagesController(
            repository: injector<PersonagesService>(),
            bingRepository: injector<BingRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => FilmsController(
            service: injector<FilmsService>(),
            bingRepository: injector<BingRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => PlanetsController(
            service: injector<PlanetsService>(),
            bingRepository: injector<BingRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SpeciesController(
            service: injector<SpeciesService>(),
            bingRepository: injector<BingRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => StarshipsController(
            service: injector<StarshipsService>(),
            bingRepository: injector<BingRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => VehiclesController(
            service: injector<VehiclesService>(),
            bingRepository: injector<BingRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => BingImagesController(
            repository: injector<BingRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryController(
            service: injector<CategoryService>(),
            bingRepository: injector<BingRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Project StarWars',
        themeMode: ThemeMode.dark,
        darkTheme: customDarkTheme(),
        theme: customLightTheme(),
        home: const HomePage(),
      ),
    );
  }
}
