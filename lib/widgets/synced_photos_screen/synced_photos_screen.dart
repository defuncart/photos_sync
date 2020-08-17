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
      body: FutureBuilder(
          future: context.watch<IDatabaseService>().getPhotos(user: UserPreferences.getUsername()),
          builder: (_, AsyncSnapshot<List<SyncedPhoto>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  snapshot.data.sort((a, b) => a.absoluteFilepath.compareTo(b.absoluteFilepath));
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) => ListTile(
                      title: Text(snapshot.data[index].filename),
                      subtitle: Text(snapshot.data[index].absoluteFilepath),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(I18n.errorPopupDescriptionText),
                  );
                }
            }

            return Container();
          }),
    );
  }
}
