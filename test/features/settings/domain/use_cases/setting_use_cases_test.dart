import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod_with_clean_arch/src/common/patterns/result_pattern.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/data/data.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/domain.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/use_cases/read_theme_use_case.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/use_cases/update_theme_use_case.dart';

import '../../settings_mocks.mocks.dart';

void main() {
  group('ReadThemeUseCaseImpl', () {
    late MockSettingRepository mockSettingRepository;
    late ReadThemeUseCaseImpl useCase;

    setUpAll(() {
      provideDummy<SettingResult>(
        SuccessResult<SettingModel, SettingException>(
          value: SettingModel(isDarkTheme: false),
        ),
      );
      provideDummy<SettingUpdateResult>(
        SuccessResult<void, SettingException>(value: null),
      );
    });

    setUp(() {
      mockSettingRepository = MockSettingRepository();
      useCase = ReadThemeUseCaseImpl(settingRepository: mockSettingRepository);
    });

    test('delegates call to repository', () async {
      final expected = SuccessResult<SettingModel, SettingException>(
        value: SettingModel(isDarkTheme: false),
      );
      when(mockSettingRepository.readTheme()).thenAnswer((_) async => expected);

      final result = await useCase.call();

      expect(result, expected);
      verify(mockSettingRepository.readTheme()).called(1);
    });
  });

  group('UpdateThemeUseCaseImpl', () {
    late MockSettingRepository mockSettingRepository;
    late UpdateThemeUseCaseImpl useCase;

    setUp(() {
      mockSettingRepository = MockSettingRepository();
      useCase = UpdateThemeUseCaseImpl(settingRepository: mockSettingRepository);
    });

    test('delegates call to repository', () async {
      final expected = SuccessResult<void, SettingException>(value: null);
      when(mockSettingRepository.updateTheme(isDarkTheme: anyNamed('isDarkTheme')))
          .thenAnswer((_) async => expected);

      final result = await useCase.call(isDarkTheme: true);

      expect(result, expected);
      verify(mockSettingRepository.updateTheme(isDarkTheme: true)).called(1);
    });
  });
}
