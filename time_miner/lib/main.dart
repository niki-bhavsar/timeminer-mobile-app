import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/app_setup.dart';
import 'di/bloc_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppSetup().preLaunchSetup();

  runApp(const AppBlocProvider(child: TimeMinerRepApp()));
}
