import 'package:riverpod_with_clean_arch/src/features/settings/domain/domain.dart';

abstract interface class UpdateThemeUseCase {
  Future<SettingUpdateResult> call({required bool isDarkTheme});
}

class UpdateThemeUseCaseImpl implements UpdateThemeUseCase {
  final SettingRepository settingRepository;

  UpdateThemeUseCaseImpl({required this.settingRepository});

  @override
  Future<SettingUpdateResult> call({required bool isDarkTheme}) =>
      settingRepository.updateTheme(isDarkTheme: isDarkTheme);
}
