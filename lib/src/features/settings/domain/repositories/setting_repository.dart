import 'package:riverpod_with_clean_arch/src/features/settings/domain/entities/setting_entity.dart';

abstract interface class SettingRepository {
  Future<SettingEntity> readTheme();
  Future<void> updateTheme({required bool isDarkTheme});
}
