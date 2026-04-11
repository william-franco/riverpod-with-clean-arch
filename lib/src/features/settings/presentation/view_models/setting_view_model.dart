import 'package:flutter/foundation.dart';
import 'package:riverpod_with_clean_arch/src/common/state_management/state_management.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/entities/setting_entity.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/usecases/read_theme_use_case.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/usecases/update_theme_use_case.dart';

typedef _ViewModel = StateManagement<SettingEntity>;

abstract interface class SettingViewModel extends _ViewModel {
  Future<void> getTheme();
  Future<void> changeTheme({required bool isDarkTheme});
}

class SettingViewModelImpl extends _ViewModel implements SettingViewModel {
  final ReadThemeUseCase readThemeUseCase;
  final UpdateThemeUseCase updateThemeUseCase;

  SettingViewModelImpl({
    required this.readThemeUseCase,
    required this.updateThemeUseCase,
  });

  @override
  SettingEntity build() => SettingEntity();

  @override
  Future<void> getTheme() async {
    final model = await readThemeUseCase.call();
    _emit(model);
  }

  @override
  Future<void> changeTheme({required bool isDarkTheme}) async {
    final model = state.copyWith(isDarkTheme: isDarkTheme);
    await updateThemeUseCase.call(isDarkTheme: isDarkTheme);
    _emit(model);
  }

  void _emit(SettingEntity newState) {
    emitState(newState);
    debugPrint('SettingViewModel: ${state.isDarkTheme}');
  }
}
