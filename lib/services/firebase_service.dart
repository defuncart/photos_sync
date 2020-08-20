import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:photos_sync/modules/backend/backend.dart';

/// A concrete implementation of IAuthService, ISyncService and IDatabaseService using Firebase
class FirebaseService implements IAuthService, ISyncService, IDatabaseService {
  /// Region: IAuthService

  /// Attempts to create a new user with a given email and password combination
  Future<bool> createUserAccount({@required email, @required password}) async {
    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result != null) {
        return true;
      }
    } catch (e) {
      print(e);
    }

    return false;
  }

  /// Attempts to login a user with a given email and password combination
  Future<bool> login({@required email, @required password}) async {
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result != null) {
        return true;
      }
    } catch (e) {
      print(e);
    }

    return false;
  }

  /// Attempts to logout a user
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

  /// Region: ISyncService

  /// Uploads a file
  Future<bool> uploadFile(File file, {@required SyncedPhoto photo}) async {
    if (file != null && photo != null) {
      final storageReferencePath = _filepathForPhoto(photo);
      final contentType = path.extension(file.path).toLowerCase().replaceAll('.', '');
      final storageReference = FirebaseStorage.instance.ref().child(storageReferencePath);
      final uploadTask = storageReference.putFile(
        file,
        StorageMetadata(
          contentType: contentType,
        ),
      );
      final result = await uploadTask.onComplete;
      if (result.error == null) {
        await addPhoto(photo);

        return true;
      }
    }

    return false;
  }

  /// Downloads a file
  Future<File> downloadFile(SyncedPhoto photo, {@required String filepath}) async {
    final storageReference = FirebaseStorage.instance.ref().child(_filepathForPhoto(photo));
    try {
      final url = await storageReference.getDownloadURL();
      if (url != null) {
        try {
          final response = await http.get(url);
          if (response != null) {
            return File(filepath).writeAsBytes(response.bodyBytes);
          }
        } catch (e) {
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  /// Deletes a file
  Future<void> deleteFile(SyncedPhoto photo) async {
    final storageReference = FirebaseStorage.instance.ref().child(_filepathForPhoto(photo));
    try {
      await storageReference.delete();

      await removePhoto(photo);
    } catch (e) {
      print(e);
    }
  }

  /// Returns the storage filepath  for a synced photo
  String _filepathForPhoto(SyncedPhoto photo) => '${photo.user}/${photo.folder}/${photo.filename}';

  /// Region: IDatabaseService

  /// Adds photo data to the database
  Future<void> addPhoto(SyncedPhoto photo) async {
    final documentReference = _documentReferenceFromSyncedPhoto(photo);
    await Firestore.instance.runTransaction((transaction) async {
      await transaction.set(
        documentReference,
        photo.toJson(),
      );
    });
  }

  /// Removes photo data from the database
  Future<void> removePhoto(SyncedPhoto photo) async {
    final documentReference = _documentReferenceFromSyncedPhoto(photo);
    await documentReference.delete();
  }

  /// Gets all synced photo data from the database
  Future<List<SyncedPhoto>> getPhotos({@required String user}) async {
    final snapshot = await Firestore.instance.collection(user).getDocuments();
    return snapshot.documents.map((doc) => SyncedPhoto.fromJson(doc.data)).toList();
  }

  /// Returns a DocumentReference for a synced photo
  DocumentReference _documentReferenceFromSyncedPhoto(SyncedPhoto photo) =>
      Firestore.instance.collection('${photo.user}').document('${photo.folder}|${photo.filename}');
}
