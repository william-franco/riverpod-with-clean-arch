import 'package:flutter/foundation.dart';
import 'package:riverpod_with_clean_arch/src/common/patterns/app_state_pattern.dart';
import 'package:riverpod_with_clean_arch/src/common/state_management/state_management.dart';
import 'package:riverpod_with_clean_arch/src/features/users/data/data.dart';
import 'package:riverpod_with_clean_arch/src/features/users/domain/domain.dart';

typedef UsersState = AppState<List<UserEntity>, UserException>;

typedef _ViewModel = StateManagement<UsersState>;

abstract interface class UserViewModel extends _ViewModel {
  Future<void> getAllUsers();
}

class UserViewModelImpl extends _ViewModel implements UserViewModel {
  final GetAllUsersUseCase getAllUsersUseCase;

  UserViewModelImpl({required this.getAllUsersUseCase});

  @override
  UsersState build() => const InitialState();

  @override
  Future<void> getAllUsers() async {
    _emit(LoadingState());

    final result = await getAllUsersUseCase.call();

    final state = result.fold<UsersState>(
      onSuccess: (value) => SuccessState(data: value),
      onError: (error) => ErrorState(error: error),
    );

    _emit(state);
  }

  void _emit(UsersState newState) {
    emitState(newState);
    debugPrint('User state: $state');
  }
}
