import 'package:riverpod_with_clean_arch/src/features/settings/domain/entities/setting_entity.dart';

class SettingModel extends SettingEntity {
  @override
  final bool isDarkTheme;

  SettingModel({this.isDarkTheme = false});
}
