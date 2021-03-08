import 'package:flutter/material.dart';
import 'package:photos_sync/configs/route_names.dart';
import 'package:photos_sync/enums/client_type.dart';
import 'package:photos_sync/i18n.dart';
import 'package:photos_sync/modules/backend/backend.dart';
import 'package:photos_sync/modules/user_preferences/user_preferences.dart';
import 'package:photos_sync/utils/device_utils.dart';
import 'package:photos_sync/widgets/home_screen/downloader_screen.dart';
import 'package:photos_sync/widgets/home_screen/uploader_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static final _mapMenuItemCallback = <int, void Function(BuildContext)>{
    0: (BuildContext context) async {
      await context.read<IAuthService>().logout();
      await UserPreferences.setUsername('');
      Navigator.of(context).pushReplacementNamed(RouteNames.welcomeScreen);
    },
    1: (BuildContext context) => Navigator.of(context).pushNamed(RouteNames.syncedPhotosScreen),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<int>(
            icon: Icon(Icons.more_vert),
            onSelected: (index) async => _mapMenuItemCallback[index]!(context),
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 1,
                child: Text(I18n.homeScreenSyncedPhotosButtonText),
              ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: 0,
                child: Text(I18n.homeScreenLogoutButtonText),
              ),
            ],
          ),
        ],
      ),
      body: _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatefulWidget {
  const _HomePageContent({Key? key}) : super(key: key);

  @override
  __HomePageContentState createState() => __HomePageContentState();
}

class __HomePageContentState extends State<_HomePageContent> {
  @override
  Widget build(BuildContext context) {
    final clientType = UserPreferences.getClientType();
    if (clientType == null) {
      _initializeClientType();
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return clientType == ClientType.uploader ? UploaderScreen() : DownloaderScreen();
    }
  }

  void _initializeClientType() {
    Future.microtask(() async {
      final clientType = DeviceUtils.isMobile ? ClientType.uploader : ClientType.downloader;
      await UserPreferences.setClientType(clientType);
      setState(() {});
    });
  }
}
