import 'package:flutter/foundation.dart';
import 'package:riverpod_with_clean_arch/src/common/patterns/state_pattern.dart';
import 'package:riverpod_with_clean_arch/src/common/state_management/state_management.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/data/data.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/domain.dart';

typedef SettingsState = StatePattern<SettingEntity, SettingException>;

typedef _ViewModel = StateManagement<SettingsState>;

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
  SettingsState build() => InitialState();

  @override
  Future<void> getTheme() async {
    _emit(LoadingState());

    final result = await readThemeUseCase.call();

    final state = result.fold<SettingsState>(
      onSuccess: (value) => SuccessState(data: value),
      onError: (error) => ErrorState(error: error),
    );

    _emit(state);
  }

  @override
  Future<void> changeTheme({required bool isDarkTheme}) async {
    _emit(LoadingState());

    final result = await updateThemeUseCase.call(isDarkTheme: isDarkTheme);

    final state = result.fold<SettingsState>(
      onSuccess: (_) => SuccessState(data: SettingEntity(isDarkTheme: isDarkTheme)),
      onError: (error) => ErrorState(error: error),
    );

    _emit(state);
  }

  void _emit(SettingsState newState) {
    emitState(newState);
    debugPrint('SettingViewModel: $state');
  }
}
