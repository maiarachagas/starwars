import 'package:flutter/material.dart';

import 'app.dart';
import 'app/services/dependency_injection.dart';

void main() async {
  await DependencyInjection.inject();

  runApp(const MyApp());
}
