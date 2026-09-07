import 'package:riverpod_with_clean_arch/src/features/settings/domain/domain.dart';

class SettingModel extends SettingEntity {
  final bool isDarkTheme;

  SettingModel({this.isDarkTheme = false});
}
