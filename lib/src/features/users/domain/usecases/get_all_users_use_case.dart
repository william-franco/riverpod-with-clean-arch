import 'package:riverpod_with_clean_arch/src/common/results/result.dart';
import 'package:riverpod_with_clean_arch/src/features/users/domain/entities/user_entity.dart';
import 'package:riverpod_with_clean_arch/src/features/users/domain/repositories/user_repository.dart';

typedef UserResult = Result<List<UserEntity>, Exception>;

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
