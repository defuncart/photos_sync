import 'package:meta/meta.dart';

import '../models/synced_photo.dart';

/// A service which manipulates a database of photo data
abstract class IDatabaseService {
  /// Adds photo data to the database
  Future<void> addPhoto(SyncedPhoto photo);

  /// Removes photo data from the database
  Future<void> removePhoto(SyncedPhoto photo);

  /// Gets all synced photo data from the database
  Future<List<SyncedPhoto>> getPhotos({@required String user});
}
