import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract class FirestorageService {
  Future<String> uploadDocument(
      File? document, String documentReference, String documentId);
}

class FirestorageServiceImpl implements FirestorageService {
  final FirebaseStorage _storage;
  FirestorageServiceImpl(this._storage);
  @override
  Future<String> uploadDocument(
      File? document, String documentReference, String documentId) async {
    await _storage.ref(documentReference).child(documentId).putFile(document!);
    return await _storage
        .ref(documentReference)
        .child(documentId)
        .getDownloadURL();
  }
}
