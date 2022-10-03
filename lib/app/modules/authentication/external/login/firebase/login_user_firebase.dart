import 'package:smart_planner/app/core/services/firebase_auth_service.dart';
import 'package:smart_planner/app/modules/authentication/infrastructure/datasources/login_user_datasource.dart';
import 'package:smart_planner/app/modules/authentication/infrastructure/models/user_result_model.dart';

class LoginUserFirebase implements LoginUserDatasource {
  final FirebaseAuthService _authService;

  LoginUserFirebase(this._authService);
  @override
  Future<UserResultModel> loginWithEmailAndPassword(
          String email, String password) async =>
      await _authService.loginWithEmailAndPassword(email, password);
}
