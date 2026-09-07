import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod_with_clean_arch/src/common/patterns/result_pattern.dart';
import 'package:riverpod_with_clean_arch/src/common/patterns/state_pattern.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/data/data.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/domain.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/presentation/view_models/setting_view_model.dart';

import '../../settings_mocks.mocks.dart';

void main() {
  group('SettingViewModelImpl', () {
    late MockReadThemeUseCase mockReadThemeUseCase;
    late MockUpdateThemeUseCase mockUpdateThemeUseCase;
    late SettingViewModelImpl viewModel;

    setUpAll(() {
      provideDummy<SettingResult>(
        SuccessResult<SettingModel, SettingException>(
          value: SettingModel(isDarkTheme: false),
        ),
      );
      provideDummy<SettingResult>(
        ErrorResult<SettingModel, SettingException>(
          error: SettingException('dummy'),
        ),
      );
      provideDummy<SettingUpdateResult>(
        SuccessResult<void, SettingException>(value: null),
      );
      provideDummy<SettingUpdateResult>(
        ErrorResult<void, SettingException>(
          error: SettingException('dummy'),
        ),
      );
    });

    setUp(() {
      mockReadThemeUseCase = MockReadThemeUseCase();
      mockUpdateThemeUseCase = MockUpdateThemeUseCase();
      viewModel = SettingViewModelImpl(
        readThemeUseCase: mockReadThemeUseCase,
        updateThemeUseCase: mockUpdateThemeUseCase,
      );
    });

    tearDown(() => viewModel.dispose());

    test('starts with InitialState', () {
      expect(viewModel.state, isA<InitialState>());
    });

    test('getTheme emits LoadingState then SuccessState on success', () async {
      when(mockReadThemeUseCase.call()).thenAnswer(
        (_) async => SuccessResult(value: SettingModel(isDarkTheme: true)),
      );

      final states = <SettingsState>[];
      viewModel.addListener(() => states.add(viewModel.state));

      await viewModel.getTheme();

      expect(states.length, 2);
      expect(states[0], isA<LoadingState>());
      expect(states[1], isA<SuccessState>());
    });

    test('getTheme emits LoadingState then ErrorState on failure', () async {
      when(mockReadThemeUseCase.call()).thenAnswer(
        (_) async => ErrorResult(error: SettingException('failed')),
      );

      final states = <SettingsState>[];
      viewModel.addListener(() => states.add(viewModel.state));

      await viewModel.getTheme();

      expect(states.length, 2);
      expect(states[1], isA<ErrorState>());
    });

    test('changeTheme emits LoadingState then SuccessState on success', () async {
      when(mockUpdateThemeUseCase.call(isDarkTheme: anyNamed('isDarkTheme')))
          .thenAnswer((_) async => SuccessResult(value: null));

      final states = <SettingsState>[];
      viewModel.addListener(() => states.add(viewModel.state));

      await viewModel.changeTheme(isDarkTheme: true);

      expect(states.length, 2);
      expect(states[1], isA<SuccessState>());
    });
  });
}
