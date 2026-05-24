import 'package:riverpod_with_clean_arch/src/common/constants/api_constant.dart';
import 'package:riverpod_with_clean_arch/src/common/patterns/result_pattern.dart';
import 'package:riverpod_with_clean_arch/src/common/services/connection_service.dart';
import 'package:riverpod_with_clean_arch/src/common/services/http_service.dart';
import 'package:riverpod_with_clean_arch/src/features/users/data/data.dart';

class UserDataSourceImpl implements UserDataSource {
  final ConnectionService connectionService;
  final HttpService httpService;

  UserDataSourceImpl({
    required this.connectionService,
    required this.httpService,
  });

  @override
  Future<UserDataResult> findAllUsers() async {
    try {
      await connectionService.checkConnection();

      if (!connectionService.isConnected) {
        return ErrorResult(error: UserException('Device not connected.'));
      }

      final result = await httpService.getData(path: ApiConstant.users);

      if (result.statusCode == 200 && result.data != null) {
        final users = (result.data as List)
            .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
            .toList();

        return SuccessResult(value: users);
      }

      return ErrorResult(
        error: UserException('Failed to fetch users: ${result.statusCode}'),
      );
    } catch (error) {
      return ErrorResult(error: UserException('Unexpected error: $error'));
    }
  }
}
