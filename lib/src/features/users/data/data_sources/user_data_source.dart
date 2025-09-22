import 'package:riverpod_with_clean_arch/src/common/results/result.dart';
import 'package:riverpod_with_clean_arch/src/features/users/data/models/user_model.dart';

typedef UserResult = Result<List<UserModel>, Exception>;

abstract interface class UserDataSource {
  Future<UserResult> findAllUsers();
}
