import 'dart:io';

import 'package:meta/meta.dart';

import '../models/synced_photo.dart';

/// A service which syncs files with a remote server
abstract class ISyncService {
  /// Uploads a file
  Future<bool> uploadFile(File file, {@required SyncedPhoto photo});

  /// Determines a file's url
  Future<String> getFileUrl(SyncedPhoto photo);

  /// Downloads a file
  Future<File> downloadFile(SyncedPhoto photo);

  /// Deletes a file
  Future<void> deleteFile(SyncedPhoto photo);
}
