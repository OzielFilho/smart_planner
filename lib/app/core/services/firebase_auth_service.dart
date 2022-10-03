import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_planner/app/modules/authentication/infrastructure/models/user_result_model.dart';

abstract class FirebaseAuthService {
  Future<UserResultModel> loginWithEmailAndPassword(
      String email, String password);
}

class FirebaseAuthServiceImpl implements FirebaseAuthService {
  final FirebaseAuth _auth;

  FirebaseAuthServiceImpl(this._auth);

  @override
  Future<UserResultModel> loginWithEmailAndPassword(
      String email, String password) async {
    final login = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return UserResultModel(
        login.user?.displayName ?? '', login.user?.email ?? '');
  }
}
