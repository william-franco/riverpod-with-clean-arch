import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod_with_clean_arch/src/common/patterns/result_pattern.dart';
import 'package:riverpod_with_clean_arch/src/features/users/data/data.dart';
import 'package:riverpod_with_clean_arch/src/features/users/domain/domain.dart';
import 'package:riverpod_with_clean_arch/src/features/users/domain/use_cases/get_all_users_use_case.dart';

import '../../users_mocks.mocks.dart';

void main() {
  group('GetAllUsersUseCaseImpl', () {
    late MockUserRepository mockUserRepository;
    late GetAllUsersUseCaseImpl useCase;

    setUpAll(() {
      provideDummy<UserResult>(
        SuccessResult<List<UserEntity>, UserException>(value: []),
      );
    });

    setUp(() {
      mockUserRepository = MockUserRepository();
      useCase = GetAllUsersUseCaseImpl(userRepository: mockUserRepository);
    });

    test('delegates call to repository', () async {
      final expected = SuccessResult<List<UserModel>, UserException>(value: []);
      when(mockUserRepository.findAllUsers()).thenAnswer((_) async => expected);

      final result = await useCase.call();

      expect(result, expected);
      verify(mockUserRepository.findAllUsers()).called(1);
    });
  });
}
