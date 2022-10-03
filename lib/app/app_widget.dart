import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/theme/theme_app.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SmartPlanner',
      theme: ThemeApp.theme,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
