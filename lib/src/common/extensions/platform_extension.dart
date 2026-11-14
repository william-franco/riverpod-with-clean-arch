import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:material_ui/material_ui.dart';

extension PlatformExtension on BuildContext {
  bool get isDesktop =>
      Platform.isLinux || Platform.isMacOS || Platform.isWindows;
  bool get isMobile => Platform.isAndroid || Platform.isIOS;
  bool get isWeb => kIsWeb;
}
