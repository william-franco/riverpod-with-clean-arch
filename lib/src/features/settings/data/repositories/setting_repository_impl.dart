import 'package:riverpod_with_clean_arch/src/features/settings/data/data.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/domain.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingDataSource settingDataSource;

  SettingRepositoryImpl({required this.settingDataSource});

  @override
  Future<SettingResult> readTheme() => settingDataSource.readTheme();

  @override
  Future<SettingUpdateResult> updateTheme({required bool isDarkTheme}) =>
      settingDataSource.updateTheme(isDarkTheme: isDarkTheme);
}
