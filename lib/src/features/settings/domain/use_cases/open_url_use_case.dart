import 'package:riverpod_with_clean_arch/src/features/settings/domain/domain.dart';

abstract interface class OpenUrlUseCase {
  Future<void> call({required Uri url});
}

class OpenUrlUseCaseImpl implements OpenUrlUseCase {
  final SettingRepository settingRepository;

  OpenUrlUseCaseImpl({required this.settingRepository});

  @override
  Future<void> call({required Uri url}) => settingRepository.openUrl(url: url);
}
