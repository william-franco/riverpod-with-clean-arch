import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod_with_clean_arch/src/common/patterns/result_pattern.dart';
import 'package:riverpod_with_clean_arch/src/features/users/data/data.dart';
import 'package:riverpod_with_clean_arch/src/features/users/data/data_sources/user_data_source_impl.dart';

import '../../users_mocks.mocks.dart';

void main() {
  group('UserDataSourceImpl', () {
    late MockConnectionService mockConnectionService;
    late MockHttpService mockHttpService;
    late UserDataSourceImpl dataSource;

    final tUserJson = [
      {
        'id': 1,
        'name': 'Leanne Graham',
        'username': 'Bret',
        'email': 'Sincere@april.biz',
        'phone': '1-770-736-0860',
        'website': 'hildegard.org',
        'address': {
          'street': 'Kulas Light',
          'suite': 'Apt. 556',
          'city': 'Gwenborough',
          'zipcode': '92998-3874',
          'geo': {'lat': '-37.3159', 'lng': '81.1496'},
        },
        'company': {
          'name': 'Romaguera-Crona',
          'catchPhrase': 'Multi-layered client-server neural-net',
          'bs': 'harness real-time e-markets',
        },
      },
    ];

    setUp(() {
      mockConnectionService = MockConnectionService();
      mockHttpService = MockHttpService();
      dataSource = UserDataSourceImpl(
        connectionService: mockConnectionService,
        httpService: mockHttpService,
      );
    });

    test('returns SuccessResult when connected and API returns 200', () async {
      when(mockConnectionService.checkConnection()).thenAnswer((_) async {});
      when(mockConnectionService.isConnected).thenReturn(true);
      when(mockHttpService.getData(path: anyNamed('path'))).thenAnswer(
        (_) async => (statusCode: 200, data: tUserJson, error: null),
      );

      final result = await dataSource.findAllUsers();

      expect(result, isA<SuccessResult<List<UserModel>, UserException>>());
      expect(
        (result as SuccessResult<List<UserModel>, UserException>).value.first.name,
        'Leanne Graham',
      );
    });

    test('returns ErrorResult when device is not connected', () async {
      when(mockConnectionService.checkConnection()).thenAnswer((_) async {});
      when(mockConnectionService.isConnected).thenReturn(false);

      final result = await dataSource.findAllUsers();

      expect(result, isA<ErrorResult<List<UserModel>, UserException>>());
    });

    test('returns ErrorResult when API fails', () async {
      when(mockConnectionService.checkConnection()).thenAnswer((_) async {});
      when(mockConnectionService.isConnected).thenReturn(true);
      when(mockHttpService.getData(path: anyNamed('path'))).thenAnswer(
        (_) async => (statusCode: 500, data: null, error: 'Server error'),
      );

      final result = await dataSource.findAllUsers();

      expect(result, isA<ErrorResult<List<UserModel>, UserException>>());
    });
  });
}
