import 'package:riverpod_with_clean_arch/src/common/results/result.dart';
import 'package:riverpod_with_clean_arch/src/features/users/domain/entities/user_entity.dart';

typedef UserResult = Result<List<UserEntity>, Exception>;

abstract interface class UserRepository {
  Future<UserResult> findAllUsers();
}
