import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_planner/app/modules/splash/infrastructure/repositories/splash_repository_impl.dart';
import 'package:smart_planner/app/modules/splash/presentation/controllers/get_user_logged_bloc.dart';
import 'package:smart_planner/app/modules/splash/presentation/splash_page.dart';

import 'domain/usecases/get_user_logged.dart';
import 'external/user_logged_firebase.dart';

class SplashModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => UserLoggedFirebase(i())),
    Bind((i) => SplashRepositoryImpl(i(), i())),
    Bind((i) => GetUserLogged(i())),
    Bind((i) => GetUserLoggedBloc(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const SplashPage()),
  ];
}
