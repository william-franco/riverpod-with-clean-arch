import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod_with_clean_arch/src/common/patterns/result_pattern.dart';
import 'package:riverpod_with_clean_arch/src/features/users/data/data.dart';
import 'package:riverpod_with_clean_arch/src/features/users/data/repositories/user_repository_impl.dart';
import 'package:riverpod_with_clean_arch/src/features/users/domain/domain.dart';

import '../../users_mocks.mocks.dart';

void main() {
  group('UserRepositoryImpl', () {
    late MockUserDataSource mockUserDataSource;
    late UserRepositoryImpl repository;

    setUpAll(() {
      provideDummy<UserDataResult>(
        SuccessResult<List<UserModel>, UserException>(value: []),
      );
    });

    setUp(() {
      mockUserDataSource = MockUserDataSource();
      repository = UserRepositoryImpl(userDataSource: mockUserDataSource);
    });

    test('delegates findAllUsers to data source', () async {
      final expected = SuccessResult<List<UserModel>, UserException>(value: []);
      when(mockUserDataSource.findAllUsers()).thenAnswer((_) async => expected);

      final result = await repository.findAllUsers();

      expect(result, expected);
      verify(mockUserDataSource.findAllUsers()).called(1);
    });
  });
}
