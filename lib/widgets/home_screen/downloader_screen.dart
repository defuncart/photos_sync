import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photos_sync/i18n.dart';
import 'package:photos_sync/modules/backend/backend.dart';
import 'package:photos_sync/modules/user_preferences/user_preferences.dart';
import 'package:photos_sync/widgets/common/custom_button.dart';
import 'package:photos_sync/widgets/common/error_dialog.dart';
import 'package:provider/provider.dart';

class DownloaderScreen extends StatefulWidget {
  const DownloaderScreen({Key? key}) : super(key: key);

  @override
  _DownloaderScreenState createState() => _DownloaderScreenState();
}

class _DownloaderScreenState extends State<DownloaderScreen> {
  bool _isSyncing = false;
  var _totalPhotosToSync = 0;
  var _photosAlreadySynced = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isSyncing
          ? Text(I18n.downloaderScreenDownloadingText(
              completed: _photosAlreadySynced,
              total: _totalPhotosToSync,
            ))
          : CustomButton(
              buttonText: I18n.downloaderScreenSyncButtonText,
              onPressed: () async {
                final syncedPhotos =
                    await context.read<IDatabaseService>().getPhotos(user: UserPreferences.getUsername()!);
                if (syncedPhotos.isNotEmpty) {
                  setState(() {
                    _isSyncing = true;
                    _totalPhotosToSync = syncedPhotos.length;
                    _photosAlreadySynced = 0;
                  });

                  final downloadsDirectory = await getDownloadsDirectory();
                  if (downloadsDirectory != null) {
                    final syncDirectory = '${downloadsDirectory.path}/PhotoSync';
                    if (!Directory(syncDirectory).existsSync()) {
                      Directory(syncDirectory).createSync(recursive: true);
                    }

                    for (final syncedPhoto in syncedPhotos) {
                      final photoDirectory = '$syncDirectory/${syncedPhoto.folder}';
                      if (!Directory(photoDirectory).existsSync()) {
                        Directory(photoDirectory).createSync(recursive: true);
                      }

                      final filepath = '$photoDirectory/${syncedPhoto.filename}';
                      if (!File(filepath).existsSync()) {
                        final photoAsFile = await context.read<ISyncService>().downloadFile(
                              syncedPhoto,
                              filepath: filepath,
                            );
                        if (photoAsFile == null) {
                          showErrorDialog(context);
                          break;
                        }
                      }

                      setState(() {
                        _photosAlreadySynced++;
                      });
                    }
                  } else {
                    print('No access to downloads directory.');
                  }

                  setState(() {
                    _isSyncing = false;
                  });

                  // TODO show confirmation to user
                }
              },
            ),
    );
  }
}
