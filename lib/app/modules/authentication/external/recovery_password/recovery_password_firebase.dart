import '../../../../core/services/firebase_auth_service.dart';
import '../../infrastructure/datasources/recovery_password_datasource.dart';

class RecoveryPasswordFirebase implements RecoveryPasswordDatasource {
  final FirebaseAuthService _authService;

  RecoveryPasswordFirebase(this._authService);

  @override
  Future<String> recoveryWithEmail(String email) async =>
      await _authService.recoveryPasswordEmail(email);
}
