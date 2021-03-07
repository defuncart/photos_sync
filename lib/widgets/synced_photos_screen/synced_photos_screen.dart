import 'package:flutter/material.dart';
import 'package:photos_sync/i18n.dart';
import 'package:photos_sync/modules/backend/backend.dart';
import 'package:photos_sync/modules/user_preferences/user_preferences.dart';
import 'package:photos_sync/widgets/common/confirm_dialog.dart';
import 'package:provider/provider.dart';

class SyncedPhotosScreen extends StatefulWidget {
  const SyncedPhotosScreen({Key? key}) : super(key: key);

  @override
  _SyncedPhotosScreenState createState() => _SyncedPhotosScreenState();
}

class _SyncedPhotosScreenState extends State<SyncedPhotosScreen> {
  Future<List<SyncedPhoto>>? _syncedPhotosFuture;

  @override
  void initState() {
    super.initState();

    _syncedPhotosFuture = context.read<IDatabaseService>().getPhotos(user: UserPreferences.getUsername()!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
            icon: Icon(Icons.more_vert),
            onSelected: (_) async {
              final shouldDeleteAll = await (showConfirmDialog(
                context: context,
                title: I18n.syncAllPhotosPopupTitleText,
                description: I18n.syncAllPhotosPopupDescriptionText,
              ));
              if (shouldDeleteAll != null && shouldDeleteAll) {
                final photos = await context.read<IDatabaseService>().getPhotos(user: UserPreferences.getUsername()!);
                for (final photo in photos) {
                  await context.read<ISyncService>().deleteFile(photo);
                }

                setState(() {
                  _syncedPhotosFuture =
                      context.read<IDatabaseService>().getPhotos(user: UserPreferences.getUsername()!);
                });
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
        future: _syncedPhotosFuture,
        builder: (_, AsyncSnapshot<List<SyncedPhoto>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.active:
              return Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                snapshot.data!.sort((a, b) => a.absoluteFilepath!.compareTo(b.absoluteFilepath!));
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => Dismissible(
                    key: Key(snapshot.data![index].absoluteFilepath!),
                    direction: DismissDirection.endToStart,
                    child: ListTile(
                      title: Text(snapshot.data![index].filename!),
                      subtitle: Text(snapshot.data![index].absoluteFilepath!),
                    ),
                    background: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onDismissed: (_) => context.read<ISyncService>().deleteFile(snapshot.data![index]),
                    confirmDismiss: (_) async => await showConfirmDialog(
                      context: context,
                      title: I18n.syncSinglePhotoPopupTitleText,
                      description: I18n.syncSinglePhotoPopupDescriptionText,
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text(I18n.errorPopupDescriptionText),
                );
              }
          }
        },
      ),
    );
  }
}
