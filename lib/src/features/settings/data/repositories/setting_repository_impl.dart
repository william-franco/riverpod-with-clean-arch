import 'package:riverpod_with_clean_arch/src/features/settings/data/data.dart';
import 'package:riverpod_with_clean_arch/src/common/services/url_launcher_service.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/domain.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingDataSource settingDataSource;

  final UrlLauncherService urlLauncherService;

  SettingRepositoryImpl({
    required this.settingDataSource,
    required this.urlLauncherService,
  });

  @override
  Future<void> openUrl({required Uri url}) =>
      urlLauncherService.openUrl(url: url);

  @override
  Future<SettingResult> readTheme() => settingDataSource.readTheme();

  @override
  Future<SettingUpdateResult> updateTheme({required bool isDarkTheme}) =>
      settingDataSource.updateTheme(isDarkTheme: isDarkTheme);
}
