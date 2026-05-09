import 'package:riverpod_with_clean_arch/src/features/users/domain/domain.dart';

abstract interface class GetAllUsersUseCase {
  Future<UserResult> call();
}

class GetAllUsersUseCaseImpl implements GetAllUsersUseCase {
  final UserRepository userRepository;

  GetAllUsersUseCaseImpl({required this.userRepository});

  @override
  Future<UserResult> call() async {
    try {
      return await userRepository.findAllUsers();
    } catch (error) {
      throw Exception('GetAllUsersUseCase: $error');
    }
  }
}
