import 'package:app_teste_unitario/app/controllers/bing_images_controller.dart';
import 'package:app_teste_unitario/app/controllers/personages_controller.dart';
import 'package:app_teste_unitario/app/services/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/commons/custom_color.dart';
import 'app/repositories/bing_repository.dart';
import 'app/repositories/swapi_repository.dart';
import 'app/views/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PersonagesController(
            repository: injector<SwapiRepository>(),
            bingRepository: injector<BingRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => BingImagesController(
            repository: injector<BingRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        darkTheme: customDarkTheme(),
        theme: customLightTheme(),
        home: const HomePage(),
      ),
    );
  }
}
