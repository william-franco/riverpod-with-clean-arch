import 'package:riverpod_with_clean_arch/src/features/settings/domain/domain.dart';

abstract interface class SettingRepository {
  Future<SettingEntity> readTheme();
  Future<void> updateTheme({required bool isDarkTheme});
}
