import 'package:riverpod_with_clean_arch/src/features/settings/domain/repositories/setting_repository.dart';

abstract interface class UpdateThemeUseCase {
  Future<void> call({required bool isDarkTheme});
}

class UpdateThemeUseCaseImpl implements UpdateThemeUseCase {
  final SettingRepository settingRepository;

  UpdateThemeUseCaseImpl({required this.settingRepository});

  @override
  Future<void> call({required bool isDarkTheme}) async {
    try {
      await settingRepository.updateTheme(isDarkTheme: isDarkTheme);
    } catch (error) {
      throw Exception('UpdateThemeUseCase: $error');
    }
  }
}
