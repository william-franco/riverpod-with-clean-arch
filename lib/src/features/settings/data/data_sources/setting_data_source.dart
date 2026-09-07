import 'package:riverpod_with_clean_arch/src/common/patterns/result_pattern.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/data/data.dart';

typedef SettingDataResult = ResultPattern<SettingModel, SettingException>;
typedef SettingDataUpdateResult = ResultPattern<void, SettingException>;

abstract interface class SettingDataSource {
  Future<SettingDataResult> readTheme();
  Future<SettingDataUpdateResult> updateTheme({required bool isDarkTheme});
}
