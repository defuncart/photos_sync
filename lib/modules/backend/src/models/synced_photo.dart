import 'package:photos_sync/extensions/map_extensions.dart';

/// A model describing a synced photo's data.
class SyncedPhoto {
  static const _emptyString = '';

  final String user;
  final String folder;
  final String filename;
  final String absoluteFilepath;

  const SyncedPhoto({
    required this.user,
    required this.folder,
    required this.filename,
    required this.absoluteFilepath,
  })   : assert(user != _emptyString),
        assert(folder != _emptyString),
        assert(filename != _emptyString),
        assert(absoluteFilepath != _emptyString);

  factory SyncedPhoto.fromJson(Map<String, dynamic>? json) => SyncedPhoto(
        user: json.tryParse('user') ?? '',
        folder: json.tryParse('folder') ?? '',
        filename: json.tryParse('filename') ?? '',
        absoluteFilepath: json.tryParse('absoluteFilepath') ?? '',
      );

  Map<String, dynamic> toJson() => {
        'user': user,
        'folder': folder,
        'filename': filename,
        'absoluteFilepath': absoluteFilepath,
      };

  @override
  bool operator ==(dynamic other) =>
      other is SyncedPhoto && user == other.user && absoluteFilepath == other.absoluteFilepath;

  @override
  int get hashCode => user.hashCode ^ absoluteFilepath.hashCode;

  @override
  String toString() => toJson().toString();
}
