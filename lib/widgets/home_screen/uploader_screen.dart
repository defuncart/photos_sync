import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:photos_sync/i18n.dart';
import 'package:photos_sync/modules/backend/backend.dart';
import 'package:photos_sync/modules/user_preferences/user_preferences.dart';
import 'package:photos_sync/widgets/common/custom_button.dart';
import 'package:photos_sync/widgets/common/error_dialog.dart';
import 'package:provider/provider.dart';

class UploaderScreen extends StatefulWidget {
  const UploaderScreen({
    Key key,
  }) : super(key: key);

  @override
  _UploaderScreenState createState() => _UploaderScreenState();
}

class _UploaderScreenState extends State<UploaderScreen> {
  bool _isUploading = false;
  int _photosUploaded;
  int _photosToUpload;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: _isUploading
            ? Text(I18n.homeScreenUploadingText(completed: _photosUploaded, total: _photosToUpload))
            : CustomButton(
                buttonText: I18n.homeScreenChoosePhotosButtonText,
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                    allowMultiple: true,
                    type: FileType.image,
                  );

                  if (result != null && result.files != null && result.files.isNotEmpty) {
                    final photosOnServer =
                        await context.read<IDatabaseService>().getPhotos(user: UserPreferences.getUsername());
                    final photosToUpload = <_PhotoToUpload>[];
                    for (final file in result.files) {
                      final photo = SyncedPhoto(
                        user: UserPreferences.getUsername(),
                        folder: dirname(file.path).split('/').last,
                        filename: basename(file.path),
                        absoluteFilepath: file.path,
                      );
                      if (!photosOnServer.contains(photo)) {
                        photosToUpload.add(_PhotoToUpload(file: File(file.path), photo: photo));
                      } else {
                        // TODO notify user already on server
                      }
                    }

                    if (photosToUpload.isNotEmpty) {
                      await _uploadPhotos(photosToUpload, context);
                    }
                  }
                },
              ),
      ),
    );
  }

  Future<void> _uploadPhotos(List<_PhotoToUpload> photosToUpload, BuildContext context) async {
    setState(() {
      _isUploading = true;
      _photosUploaded = 0;
      _photosToUpload = photosToUpload.length;
    });

    for (final photoToUpload in photosToUpload) {
      final success = await context.read<ISyncService>().uploadFile(photoToUpload.file, photo: photoToUpload.photo);
      if (!success) {
        showErrorDialog(context);
        break;
      }

      setState(() {
        _photosUploaded++;
      });
    }

    setState(() {
      _isUploading = false;
    });
  }
}

class _PhotoToUpload {
  final File file;
  final SyncedPhoto photo;

  const _PhotoToUpload({
    @required this.file,
    @required this.photo,
  })  : assert(file != null),
        assert(photo != null);
}
