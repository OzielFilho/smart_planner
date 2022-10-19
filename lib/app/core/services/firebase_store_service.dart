import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class FirebaseStoreService {
  Future<void> createDocument(
      Map<String, dynamic> data, String nameDocument, String idDocument);
  Future<void> updateDocument(
      Map<String, dynamic> data, String nameDocument, String idDocument);
  Future<Map<String, dynamic>?> getDocument(
      String nameDocument, String idDocument);
  Future<bool> existDocument(String nameDocument, String idDocument);
}

class FirebaseStoreServiceImpl implements FirebaseStoreService {
  final FirebaseFirestore _firestore;

  FirebaseStoreServiceImpl(this._firestore);

  @override
  Future<void> createDocument(
      Map<String, dynamic> data, String nameDocument, String idDocument) async {
    try {
      await _firestore.collection(nameDocument).doc(idDocument).set(data);
    } catch (erro) {
      debugPrint('$erro');
    }
  }

  @override
  Future<Map<String, dynamic>?> getDocument(
      String nameDocument, String idDocument) async {
    try {
      final result =
          await _firestore.collection(nameDocument).doc(idDocument).get();
      return result.data();
    } catch (e) {
      return {};
    }
  }

  @override
  Future<void> updateDocument(
      Map<String, dynamic> data, String nameDocument, String idDocument) async {
    try {
      await _firestore.collection(nameDocument).doc(idDocument).update(data);
    } catch (e) {
      debugPrint('$e');
    }
  }

  @override
  Future<bool> existDocument(String nameDocument, String idDocument) async {
    try {
      final result =
          await _firestore.collection(nameDocument).doc(idDocument).get();
      return result.exists;
    } catch (e) {
      return false;
    }
  }
}
