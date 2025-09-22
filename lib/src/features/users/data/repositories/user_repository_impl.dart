import 'package:riverpod_with_clean_arch/src/common/results/result.dart';
import 'package:riverpod_with_clean_arch/src/features/users/data/data_sources/user_data_source.dart';
import 'package:riverpod_with_clean_arch/src/features/users/data/models/user_model.dart';
import 'package:riverpod_with_clean_arch/src/features/users/domain/repositories/user_repository.dart';

typedef UserResult = Result<List<UserModel>, Exception>;

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl({required this.userDataSource});

  @override
  Future<UserResult> findAllUsers() async {
    try {
      return await userDataSource.findAllUsers();
    } catch (error) {
      throw Exception('SettingRepository: $error');
    }
  }
}
