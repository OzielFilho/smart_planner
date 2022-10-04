import '../../../core/services/firebase_auth_service.dart';
import '../infrastructure/datasource/splash_datasource.dart';

class UserLoggedFirebase implements SplashDatasource {
  final FirebaseAuthService _authService;

  UserLoggedFirebase(this._authService);

  @override
  Future<bool> getUserLogged() async {
    return await _authService.getUserLogged();
  }
}
