import 'dart:developer' show log;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:photos_sync/modules/backend/backend.dart';

/// A concrete implementation of IAuthService, ISyncService and IDatabaseService using Firebase
class FirebaseService implements IAuthService, ISyncService, IDatabaseService {
  // Region: IAuthService

  @override
  Future<bool> createUserAccount({required email, required password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      log(e.toString());
    }

    return false;
  }

  @override
  Future<bool> login({required email, required password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      log(e.toString());
    }

    return false;
  }

  @override
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      log(e.toString());
    }
  }

  // Region: ISyncService

  @override
  Future<bool> uploadFile(File file, {required SyncedPhoto photo}) async {
    final storageReferencePath = _filepathForPhoto(photo);
    final contentType = path.extension(file.path).toLowerCase().replaceAll('.', '');
    final storageReference = FirebaseStorage.instance.ref().child(storageReferencePath);
    final uploadTask = storageReference.putFile(
      file,
      SettableMetadata(
        contentType: contentType,
      ),
    );
    return await uploadTask.then((_) async {
      await addPhoto(photo);
      return true;
    }).onError((error, stackTrace) {
      log(error.toString());
      return false;
    });
  }

  @override
  Future<File?> downloadFile(SyncedPhoto photo, {required String filepath}) async {
    final storageReference = FirebaseStorage.instance.ref().child(_filepathForPhoto(photo));
    final data = await storageReference.getData();
    if (data != null) {
      return File(filepath).writeAsBytes(data);
    }

    return null;
  }

  @override
  Future<void> deleteFile(SyncedPhoto photo) async {
    final storageReference = FirebaseStorage.instance.ref().child(_filepathForPhoto(photo));
    try {
      await storageReference.delete();

      await removePhoto(photo);
    } catch (e) {
      log(e.toString());
    }
  }

  /// Returns the storage filepath  for a synced photo
  String _filepathForPhoto(SyncedPhoto photo) => '${photo.user}/${photo.folder}/${photo.filename}';

  // Region: IDatabaseService

  @override
  Future<void> addPhoto(SyncedPhoto photo) async {
    final documentReference = _documentReferenceFromSyncedPhoto(photo);
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        photo.toJson(),
      );
    });
  }

  @override
  Future<void> removePhoto(SyncedPhoto photo) async {
    final documentReference = _documentReferenceFromSyncedPhoto(photo);
    await documentReference.delete();
  }

  @override
  Future<List<SyncedPhoto>> getPhotos({required String user}) async {
    final snapshot = await FirebaseFirestore.instance.collection(user).get();
    return snapshot.docs.map((doc) => SyncedPhoto.fromJson(doc.data())).toList();
  }

  /// Returns a DocumentReference for a synced photo
  DocumentReference _documentReferenceFromSyncedPhoto(SyncedPhoto photo) =>
      FirebaseFirestore.instance.collection(photo.user).doc('${photo.folder}|${photo.filename}');
}
