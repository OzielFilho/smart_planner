import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class FirestorageService {
  Future<String> uploadDocument(File? document, String documentReference);
}

class FirestorageServiceImpl implements FirestorageService {
  final FirebaseStorage _storage;
  final FirebaseAuth _auth;
  FirestorageServiceImpl(this._storage, this._auth);
  @override
  Future<String> uploadDocument(
      File? document, String documentReference) async {
    final tokenId = _auth.currentUser!.uid;
    await _storage.ref(documentReference).child(tokenId).putFile(document!);
    return await _storage
        .ref(documentReference)
        .child(tokenId)
        .getDownloadURL();
  }
}
