import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_planner/app/core/services/firebase_store_service.dart';
import 'package:smart_planner/app/modules/authentication/infrastructure/models/user_create_account_model.dart';
import 'package:smart_planner/app/modules/authentication/infrastructure/models/user_result_model.dart';

abstract class FirebaseAuthService {
  Future<UserResultModel> loginWithEmailAndPassword(
      String email, String password);
  Future<String> recoveryPasswordEmail(String email);
  Future<String> createAccount(UserCreateAccountModel userModel);
  Future<bool> getUserLogged();
}

class FirebaseAuthServiceImpl implements FirebaseAuthService {
  final FirebaseAuth _auth;
  final FirebaseStoreService _firebaseStoreService;
  FirebaseAuthServiceImpl(this._auth, this._firebaseStoreService);

  @override
  Future<UserResultModel> loginWithEmailAndPassword(
      String email, String password) async {
    final login = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return UserResultModel(
        login.user?.displayName ?? '', login.user?.email ?? '');
  }

  @override
  Future<String> recoveryPasswordEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return '';
    } catch (erro) {
      return 'Usuário não encontrado ou Serviço indisponível';
    }
  }

  @override
  Future<String> createAccount(UserCreateAccountModel userModel) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: userModel.email, password: userModel.password);
      await _auth.currentUser!.sendEmailVerification();

      _firebaseStoreService.createDocument(
          userModel.toMap(), 'users', _auth.currentUser!.uid);
      return '';
    } catch (e) {
      return 'Usuário não pode ser criado';
    }
  }

  @override
  Future<bool> getUserLogged() async {
    try {
      return _auth.currentUser != null;
    } catch (e) {
      return false;
    }
  }
}
