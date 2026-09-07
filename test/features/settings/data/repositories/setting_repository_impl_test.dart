import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod_with_clean_arch/src/common/patterns/result_pattern.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/data/data.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/data/repositories/setting_repository_impl.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/domain.dart';

import '../../settings_mocks.mocks.dart';

void main() {
  group('SettingRepositoryImpl', () {
    late MockSettingDataSource mockSettingDataSource;
    late SettingRepositoryImpl repository;

    setUpAll(() {
      provideDummy<SettingDataResult>(
        SuccessResult<SettingModel, SettingException>(
          value: SettingModel(isDarkTheme: false),
        ),
      );
      provideDummy<SettingDataUpdateResult>(
        SuccessResult<void, SettingException>(value: null),
      );
    });

    setUp(() {
      mockSettingDataSource = MockSettingDataSource();
      repository = SettingRepositoryImpl(settingDataSource: mockSettingDataSource);
    });

    test('delegates readTheme to data source', () async {
      final expected = SuccessResult<SettingModel, SettingException>(
        value: SettingModel(isDarkTheme: true),
      );
      when(mockSettingDataSource.readTheme()).thenAnswer((_) async => expected);

      final result = await repository.readTheme();

      expect(result, expected);
      verify(mockSettingDataSource.readTheme()).called(1);
    });

    test('delegates updateTheme to data source', () async {
      final expected = SuccessResult<void, SettingException>(value: null);
      when(mockSettingDataSource.updateTheme(isDarkTheme: anyNamed('isDarkTheme')))
          .thenAnswer((_) async => expected);

      final result = await repository.updateTheme(isDarkTheme: false);

      expect(result, expected);
      verify(mockSettingDataSource.updateTheme(isDarkTheme: false)).called(1);
    });
  });
}
