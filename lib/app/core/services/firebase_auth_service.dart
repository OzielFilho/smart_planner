import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_planner/app/core/services/firebase_store_service.dart';
import 'package:smart_planner/app/core/services/firestorage_service.dart';
import 'package:smart_planner/app/modules/authentication/infrastructure/models/user_create_account_model.dart';
import 'package:smart_planner/app/modules/authentication/infrastructure/models/user_result_model.dart';

abstract class FirebaseAuthService {
  Future<UserResultModel> loginWithEmailAndPassword(
      String email, String password);
  Future<String> recoveryPasswordEmail(String email);
  Future<String> createAccount(UserCreateAccountModel userModel, File? image);
  Future<bool> getUserLogged();
  String? get getUserId;
}

class FirebaseAuthServiceImpl implements FirebaseAuthService {
  final FirebaseAuth _auth;
  final FirebaseStoreService _firebaseStoreService;
  final FirestorageService _firestorageService;
  FirebaseAuthServiceImpl(
      this._auth, this._firebaseStoreService, this._firestorageService);

  @override
  Future<UserResultModel> loginWithEmailAndPassword(
      String email, String password) async {
    final login = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    if (!_auth.currentUser!.emailVerified) {
      await _auth.signOut();
      return UserResultModel('', '');
    }
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
  Future<String> createAccount(
      UserCreateAccountModel userModel, File? image) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: userModel.email, password: userModel.password);
      await _auth.currentUser!.sendEmailVerification();
      if (image != null) {
        userModel.photo = await _firestorageService.uploadDocument(
            image, 'users', _auth.currentUser!.uid);
      }
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

  @override
  String? get getUserId => _auth.currentUser?.uid;
}
