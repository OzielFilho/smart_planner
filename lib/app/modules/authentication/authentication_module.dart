import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_planner/app/modules/authentication/infrastructure/repositories/login_user_repository_impl.dart';
import 'package:smart_planner/app/modules/authentication/infrastructure/repositories/recovery_password_repository_impl.dart';
import 'package:smart_planner/app/modules/authentication/presentation/controllers/recovery_password_user_controller/recovery_password_with_email_bloc.dart';
import 'package:smart_planner/app/modules/authentication/presentation/pages/login/login_page.dart';
import 'package:smart_planner/app/modules/authentication/presentation/pages/recovery_password/recovery_password_page.dart';

import 'domain/usecases/login/login_with_email_and_password.dart';
import 'domain/usecases/recovery_password/recovery_with_email.dart';
import 'external/login/firebase/login_user_firebase.dart';
import 'external/recovery_password/recovery_password_firebase.dart';
import 'presentation/controllers/login_user_controller/login_with_email_and_password_bloc.dart';
import 'presentation/pages/autentication_page.dart';

class AuthenticationModule extends Module {
  @override
  final List<Bind> binds = [
    //Login - Email and Password
    Bind((i) => LoginUserFirebase(i())),
    Bind((i) => LoginUserRepositoryImpl(i(), i())),
    Bind((i) => LoginWithEmailAndPassword(i())),
    Bind((i) => LoginWithEmailAndPasswordBloc(i())),
    //RecoveryPassword - Email
    Bind((i) => RecoveryPasswordFirebase(i())),
    Bind((i) => RecoveryPasswordRepositoryImpl(i(), i())),
    Bind((i) => RecoveryWithEmail(i())),
    Bind((i) => RecoveryPasswordWithEmailBloc(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const AuthenticationPage()),
    ChildRoute('/login', child: (context, args) => const LoginAppPage()),
    ChildRoute('/recovery_password',
        child: (context, args) => const RecoveryPasswordPage()),
  ];
}
