import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod_with_clean_arch/src/common/patterns/result_pattern.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/data/data.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/data/data_sources/setting_data_source_impl.dart';

import '../../settings_mocks.mocks.dart';

void main() {
  group('SettingDataSourceImpl', () {
    late MockStorageService mockStorageService;
    late SettingDataSourceImpl dataSource;

    setUp(() {
      mockStorageService = MockStorageService();
      dataSource = SettingDataSourceImpl(storageService: mockStorageService);
    });

    test('returns SuccessResult when storage read succeeds', () async {
      when(mockStorageService.getBoolValue(key: anyNamed('key')))
          .thenAnswer((_) async => true);

      final result = await dataSource.readTheme();

      expect(result, isA<SuccessResult<SettingModel, SettingException>>());
      expect(
        (result as SuccessResult<SettingModel, SettingException>).value.isDarkTheme,
        isTrue,
      );
    });

    test('returns ErrorResult when storage read throws', () async {
      when(mockStorageService.getBoolValue(key: anyNamed('key')))
          .thenThrow(Exception('storage error'));

      final result = await dataSource.readTheme();

      expect(result, isA<ErrorResult<SettingModel, SettingException>>());
    });

    test('returns SuccessResult when storage write succeeds', () async {
      when(mockStorageService.setBoolValue(
        key: anyNamed('key'),
        value: anyNamed('value'),
      )).thenAnswer((_) async {});

      final result = await dataSource.updateTheme(isDarkTheme: true);

      expect(result, isA<SuccessResult<void, SettingException>>());
    });

    test('returns ErrorResult when storage write throws', () async {
      when(mockStorageService.setBoolValue(
        key: anyNamed('key'),
        value: anyNamed('value'),
      )).thenThrow(Exception('storage error'));

      final result = await dataSource.updateTheme(isDarkTheme: false);

      expect(result, isA<ErrorResult<void, SettingException>>());
    });
  });
}
