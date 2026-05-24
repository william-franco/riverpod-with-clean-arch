import 'package:riverpod_with_clean_arch/src/common/patterns/result_pattern.dart';
import 'package:riverpod_with_clean_arch/src/features/users/data/data.dart';
import 'package:riverpod_with_clean_arch/src/features/users/domain/domain.dart';

typedef UserResult = Result<List<UserEntity>, UserException>;

abstract interface class UserRepository {
  Future<UserResult> findAllUsers();
}
