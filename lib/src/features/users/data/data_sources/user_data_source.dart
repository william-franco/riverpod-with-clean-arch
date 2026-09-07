import 'package:riverpod_with_clean_arch/src/common/patterns/result_pattern.dart';
import 'package:riverpod_with_clean_arch/src/features/users/data/data.dart';

typedef UserDataResult = ResultPattern<List<UserModel>, UserException>;

abstract interface class UserDataSource {
  Future<UserDataResult> findAllUsers();
}
