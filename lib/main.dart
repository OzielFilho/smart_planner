import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_planner/app/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then(
      (_) => runApp(ModularApp(module: AppModule(), child: const AppWidget())));
}
