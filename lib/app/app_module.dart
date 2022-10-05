import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_planner/app/core/services/firebase_auth_service.dart';
import 'package:smart_planner/app/core/services/firebase_store_service.dart';
import 'package:smart_planner/app/core/services/network_service.dart';
import 'package:smart_planner/app/modules/splash/splash_module.dart';

import 'core/services/firestorage_service.dart';
import 'modules/authentication/authentication_module.dart';
import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => FirebaseStoreServiceImpl(FirebaseFirestore.instance)),
    Bind((i) => FirestorageServiceImpl(FirebaseStorage.instance)),
    Bind((i) => FirebaseAuthServiceImpl(FirebaseAuth.instance, i(), i())),
    Bind((i) => NetworkServiceImpl()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: SplashModule()),
    ModuleRoute('/authentication', module: AuthenticationModule()),
    ModuleRoute('/home', module: HomeModule()),
  ];
}
