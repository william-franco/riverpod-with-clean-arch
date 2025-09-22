import 'package:riverpod_with_clean_arch/src/features/settings/domain/entities/setting_entity.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/repositories/setting_repository.dart';

abstract interface class ReadThemeUseCase {
  Future<SettingEntity> call();
}

class ReadThemeUseCaseImpl implements ReadThemeUseCase {
  final SettingRepository settingRepository;

  ReadThemeUseCaseImpl({required this.settingRepository});

  @override
  Future<SettingEntity> call() async {
    try {
      return await settingRepository.readTheme();
    } catch (error) {
      throw Exception('ReadThemeUseCase: $error');
    }
  }
}
