import 'package:flutter/foundation.dart';
import 'package:riverpod_with_clean_arch/src/common/patterns/app_state_pattern.dart';
import 'package:riverpod_with_clean_arch/src/features/users/domain/entities/user_entity.dart';
import 'package:riverpod_with_clean_arch/src/features/users/domain/usecases/get_all_users_use_case.dart';

typedef _ViewModel = ChangeNotifier;

typedef UsersState = AppState<List<UserEntity>>;

abstract interface class UserViewModel extends _ViewModel {
  UsersState get userState;

  Future<void> getAllUsers();
}

class UserViewModelImpl extends _ViewModel implements UserViewModel {
  final GetAllUsersUseCase getAllUsersUseCase;

  UserViewModelImpl({required this.getAllUsersUseCase});

  UsersState _userState = InitialState();

  @override
  UsersState get userState => _userState;

  @override
  Future<void> getAllUsers() async {
    _emit(LoadingState());

    final result = await getAllUsersUseCase.call();

    final state = result.fold<UsersState>(
      onSuccess: (value) => SuccessState(data: value),
      onError: (error) => ErrorState(message: '$error'),
    );

    _emit(state);
  }

  void _emit(UsersState newState) {
    if (_userState != newState) {
      _userState = newState;
      notifyListeners();
      debugPrint('User state: $_userState');
    }
  }
}
