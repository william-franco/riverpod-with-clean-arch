import 'package:riverpod_with_clean_arch/src/common/constants/value_constant.dart';
import 'package:riverpod_with_clean_arch/src/common/patterns/result_pattern.dart';
import 'package:riverpod_with_clean_arch/src/common/services/storage_service.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/data/data.dart';

class SettingDataSourceImpl implements SettingDataSource {
  final StorageService storageService;

  SettingDataSourceImpl({required this.storageService});

  @override
  Future<SettingDataResult> readTheme() async {
    try {
      final isDarkMode = await storageService.getBoolValue(
        key: ValueConstant.darkMode,
      );
      return SuccessResult(value: SettingModel(isDarkTheme: isDarkMode ?? false));
    } catch (error) {
      return ErrorResult(error: SettingException('Unexpected error: $error'));
    }
  }

  @override
  Future<SettingDataUpdateResult> updateTheme({required bool isDarkTheme}) async {
    try {
      await storageService.setBoolValue(
        key: ValueConstant.darkMode,
        value: isDarkTheme,
      );
      return SuccessResult(value: null);
    } catch (error) {
      return ErrorResult(error: SettingException('Unexpected error: $error'));
    }
  }
}
