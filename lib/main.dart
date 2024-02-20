import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'app/models/adapter/category_adapter.dart';
import 'app/services/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.inject();

  // Salvando dados no cache
  Hive
    ..initFlutter()
    ..registerAdapter(CategoryAdapterAdapter())
    ..registerAdapter(DetailAdapterAdapter());

  runApp(const MyApp());
}
