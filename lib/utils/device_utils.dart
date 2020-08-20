import 'dart:io';

class DeviceUtils {
  static bool get isMobile => Platform.isAndroid || Platform.isIOS;

  static bool get isDesktop => Platform.isMacOS;
}
