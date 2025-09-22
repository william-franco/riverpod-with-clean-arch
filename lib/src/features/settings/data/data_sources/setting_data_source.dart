import 'package:riverpod_with_clean_arch/src/features/settings/data/models/setting_model.dart';

abstract interface class SettingDataSource {
  Future<SettingModel> readTheme();
  Future<void> updateTheme({required bool isDarkTheme});
}
