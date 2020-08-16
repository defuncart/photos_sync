import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:photos_sync/configs/route_names.dart';
import 'package:photos_sync/i18n.dart';
import 'package:photos_sync/modules/backend/backend.dart';
import 'package:photos_sync/modules/user_preferences/user_preferences.dart';
import 'package:photos_sync/widgets/common/custom_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
            icon: Icon(Icons.more_vert),
            onSelected: (_) async {
              await context.read<IAuthService>().logout();
              await UserPreferences.setUsername('');
              Navigator.of(context).pushReplacementNamed(RouteNames.welcomeScreen);
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 0,
                child: Text(I18n.homeScreenLogoutButtonText),
              )
            ],
          ),
        ],
      ),
      body: _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatefulWidget {
  const _HomePageContent({
    Key key,
  }) : super(key: key);

  @override
  __HomePageContentState createState() => __HomePageContentState();
}

class __HomePageContentState extends State<_HomePageContent> {
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
                buttonText: 'Sync',
                onPressed: () async {
                  final files = await FilePicker.getMultiFile(
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'jpeg', 'png'],
                  );

                  if (files != null && files.isNotEmpty) {
                    final photosToUpload = <_PhotoToUpload>[];
                    for (final file in files) {
                      final photo = SyncedPhoto(
                        user: UserPreferences.getUsername(),
                        folder: dirname(file.path).split('/').last,
                        filename: basename(file.path),
                        absoluteFilepath: file.path,
                      );
                      photosToUpload.add(_PhotoToUpload(file: file, photo: photo));
                    }

                    await _uploadPhotos(photosToUpload, context);
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
      await context.read<ISyncService>().uploadFile(photoToUpload.file, photo: photoToUpload.photo);

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
