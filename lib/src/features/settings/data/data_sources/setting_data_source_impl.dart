import 'package:riverpod_with_clean_arch/src/common/constants/value_constant.dart';
import 'package:riverpod_with_clean_arch/src/common/services/storage_service.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/data/data_sources/setting_data_source.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/data/models/setting_model.dart';

class SettingDataSourceImpl implements SettingDataSource {
  final StorageService storageService;

  SettingDataSourceImpl({required this.storageService});

  @override
  Future<SettingModel> readTheme() async {
    try {
      final isDarkMode = await storageService.getBoolValue(
        key: ValueConstant.darkMode,
      );
      return SettingModel(isDarkTheme: isDarkMode ?? false);
    } catch (error) {
      throw Exception('SettingDataSourceImpl: $error');
    }
  }

  @override
  Future<void> updateTheme({required bool isDarkTheme}) async {
    try {
      await storageService.setBoolValue(
        key: ValueConstant.darkMode,
        value: isDarkTheme,
      );
    } catch (error) {
      throw Exception('SettingDataSourceImpl: $error');
    }
  }
}
