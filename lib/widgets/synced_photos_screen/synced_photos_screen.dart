import 'package:flutter/material.dart';
import 'package:photos_sync/i18n.dart';
import 'package:photos_sync/modules/backend/backend.dart';
import 'package:photos_sync/modules/user_preferences/user_preferences.dart';
import 'package:provider/provider.dart';

class SyncedPhotosScreen extends StatelessWidget {
  const SyncedPhotosScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
            icon: Icon(Icons.more_vert),
            onSelected: (_) async {
              final photos = await context.read<IDatabaseService>().getPhotos(user: UserPreferences.getUsername());
              for (final photo in photos) {
                await context.read<ISyncService>().deleteFile(photo);
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 0,
                child: Text(I18n.syncedPhotosScreenDeleteAllButtonText),
              ),
            ],
          ),
        ],
      ),
      body: Container(),
    );
  }
}
