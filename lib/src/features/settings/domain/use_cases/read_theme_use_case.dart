import 'package:riverpod_with_clean_arch/src/features/settings/domain/domain.dart';

abstract interface class ReadThemeUseCase {
  Future<SettingResult> call();
}

class ReadThemeUseCaseImpl implements ReadThemeUseCase {
  final SettingRepository settingRepository;

  ReadThemeUseCaseImpl({required this.settingRepository});

  @override
  Future<SettingResult> call() => settingRepository.readTheme();
}
