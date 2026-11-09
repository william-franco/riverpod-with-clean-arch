import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod_with_clean_arch/src/common/patterns/result_pattern.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/data/data.dart';

import '../../settings_mocks.mocks.dart';

void main() {
  group('SettingRepositoryImpl', () {
    late MockSettingDataSource mockSettingDataSource;
    late MockUrlLauncherService mockUrlLauncherService;
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
      mockUrlLauncherService = MockUrlLauncherService();
      repository = SettingRepositoryImpl(
        settingDataSource: mockSettingDataSource,
        urlLauncherService: mockUrlLauncherService,
      );
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
      when(
        mockSettingDataSource.updateTheme(isDarkTheme: anyNamed('isDarkTheme')),
      ).thenAnswer((_) async => expected);

      final result = await repository.updateTheme(isDarkTheme: false);

      expect(result, expected);
      verify(mockSettingDataSource.updateTheme(isDarkTheme: false)).called(1);
    });
    group('openUrl', () {
      test('delegates url to urlLauncherService', () async {
        // arrange
        final url = Uri.parse('https://github.com/william-franco');
        when(mockUrlLauncherService.openUrl(url: anyNamed('url')))
            .thenAnswer((_) async {});

        // act
        await repository.openUrl(url: url);

        // assert
        verify(mockUrlLauncherService.openUrl(url: url)).called(1);
      });

      test('throws when urlLauncherService throws', () async {
        // arrange
        when(mockUrlLauncherService.openUrl(url: anyNamed('url')))
            .thenThrow(Exception('Launch failure'));

        // act & assert
        expect(
          () => repository.openUrl(
            url: Uri.parse('https://github.com/william-franco'),
          ),
          throwsException,
        );
      });
    });
  });
}
