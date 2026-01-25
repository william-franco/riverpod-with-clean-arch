import 'package:riverpod_with_clean_arch/src/common/constants/api_constant.dart';
import 'package:riverpod_with_clean_arch/src/common/patterns/result_pattern.dart';
import 'package:riverpod_with_clean_arch/src/common/services/connection_service.dart';
import 'package:riverpod_with_clean_arch/src/common/services/http_service.dart';
import 'package:riverpod_with_clean_arch/src/features/users/data/data_sources/user_data_source.dart';
import 'package:riverpod_with_clean_arch/src/features/users/data/models/user_model.dart';

class UserDataSourceImpl implements UserDataSource {
  final ConnectionService connectionService;
  final HttpService httpService;

  UserDataSourceImpl({
    required this.connectionService,
    required this.httpService,
  });

  @override
  Future<UserResult> findAllUsers() async {
    try {
      await connectionService.checkConnection();

      if (!connectionService.isConnected) {
        return ErrorResult(error: Exception('Device not connected.'));
      }

      final result = await httpService.getData(path: ApiConstant.users);

      if (result.statusCode == 200 && result.data != null) {
        final users = (result.data as List)
            .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
            .toList();

        return SuccessResult(value: users);
      }

      return ErrorResult(
        error: Exception('Failed to fetch users: ${result.statusCode}'),
      );
    } catch (error) {
      return ErrorResult(error: Exception('Unexpected error: $error'));
    }
  }
}
