import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:riverpod_with_clean_arch/src/common/patterns/result_pattern.dart';
import 'package:riverpod_with_clean_arch/src/common/patterns/state_pattern.dart';
import 'package:riverpod_with_clean_arch/src/features/users/data/data.dart';
import 'package:riverpod_with_clean_arch/src/features/users/domain/domain.dart';
import 'package:riverpod_with_clean_arch/src/features/users/presentation/view_models/user_view_model.dart';

import '../../users_mocks.mocks.dart';

void main() {
  group('UserViewModelImpl', () {
    late MockGetAllUsersUseCase mockGetAllUsersUseCase;
    late UserViewModelImpl viewModel;

    final tUsers = [UserModel(id: 1, name: 'Leanne Graham')];

    setUpAll(() {
      provideDummy<UserResult>(
        SuccessResult<List<UserEntity>, UserException>(value: []),
      );
      provideDummy<UserResult>(
        ErrorResult<List<UserEntity>, UserException>(
          error: UserException('dummy'),
        ),
      );
    });

    setUp(() {
      mockGetAllUsersUseCase = MockGetAllUsersUseCase();
      viewModel = UserViewModelImpl(getAllUsersUseCase: mockGetAllUsersUseCase);
    });

    test('starts with InitialState', () {
      expect(viewModel.state, isA<InitialState>());
    });

    test('emits LoadingState then SuccessState on success', () async {
      when(mockGetAllUsersUseCase.call()).thenAnswer(
        (_) async => SuccessResult(value: tUsers),
      );

      final states = <UsersState>[];
      viewModel.addListener(() => states.add(viewModel.state));

      await viewModel.getAllUsers();

      expect(states.length, 2);
      expect(states[0], isA<LoadingState>());
      expect(states[1], isA<SuccessState>());
    });

    test('emits LoadingState then ErrorState on failure', () async {
      when(mockGetAllUsersUseCase.call()).thenAnswer(
        (_) async => ErrorResult(error: UserException('failed')),
      );

      final states = <UsersState>[];
      viewModel.addListener(() => states.add(viewModel.state));

      await viewModel.getAllUsers();

      expect(states.length, 2);
      expect(states[1], isA<ErrorState>());
    });
  });
}
