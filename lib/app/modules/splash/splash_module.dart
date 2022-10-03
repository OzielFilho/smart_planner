import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_planner/app/modules/splash/presentation/splash_page.dart';

class SplashModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const SplashPage()),
  ];
}
