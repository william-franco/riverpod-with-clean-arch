import 'package:riverpod_with_clean_arch/src/common/patterns/result_pattern.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/data/data.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/domain.dart';

typedef SettingResult = ResultPattern<SettingEntity, SettingException>;
typedef SettingUpdateResult = ResultPattern<void, SettingException>;

abstract interface class SettingRepository {
  Future<SettingResult> readTheme();
  Future<SettingUpdateResult> updateTheme({required bool isDarkTheme});
}
