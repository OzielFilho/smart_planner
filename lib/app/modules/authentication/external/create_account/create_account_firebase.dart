import 'dart:io';

import 'package:smart_planner/app/modules/authentication/infrastructure/datasources/create_account_datasource.dart';
import 'package:smart_planner/app/modules/authentication/infrastructure/models/user_create_account_model.dart';

import '../../../../core/services/firebase_auth_service.dart';

class CreateAccountFirebase implements CreateAccountDatasource {
  final FirebaseAuthService _authService;

  CreateAccountFirebase(this._authService);

  @override
  Future<String> createAccountWithEmailAndPassword(
      UserCreateAccountModel user, File? image) async {
    return await _authService.createAccount(user, image);
  }
}
