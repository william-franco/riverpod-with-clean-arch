import 'package:riverpod_with_clean_arch/src/features/settings/data/data.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/domain.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingDataSource settingDataSource;

  SettingRepositoryImpl({required this.settingDataSource});

  @override
  Future<SettingModel> readTheme() async {
    try {
      return await settingDataSource.readTheme();
    } catch (error) {
      throw Exception('SettingRepository: $error');
    }
  }

  @override
  Future<void> updateTheme({required bool isDarkTheme}) async {
    try {
      await settingDataSource.updateTheme(isDarkTheme: isDarkTheme);
    } catch (error) {
      throw Exception('SettingRepository: $error');
    }
  }
}
