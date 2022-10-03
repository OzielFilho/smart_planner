import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class FirebaseStoreService {
  Future<void> createDocument(
      Map<String, dynamic> data, String nameDocument, String idDocument);
  Future<void> updateDocument(Map<String, dynamic> data);
}

class FirebaseStoreServiceImpl implements FirebaseStoreService {
  final FirebaseFirestore _firestore;

  FirebaseStoreServiceImpl(this._firestore);

  @override
  Future<void> updateDocument(Map<String, dynamic> data) {
    // TODO: implement updateDocument
    throw UnimplementedError();
  }

  @override
  Future<void> createDocument(
      Map<String, dynamic> data, String nameDocument, String idDocument) async {
    try {
      await _firestore.collection(nameDocument).doc(idDocument).set(data);
    } catch (erro) {
      debugPrint('$erro');
    }
  }
}
