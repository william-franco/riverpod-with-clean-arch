import 'package:mockito/annotations.dart';
import 'package:riverpod_with_clean_arch/src/common/services/connection_service.dart';
import 'package:riverpod_with_clean_arch/src/common/services/http_service.dart';
import 'package:riverpod_with_clean_arch/src/common/services/storage_service.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/data/data_sources/setting_data_source.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/repositories/setting_repository.dart';
import 'package:riverpod_with_clean_arch/src/features/users/data/data_sources/user_data_source.dart';
import 'package:riverpod_with_clean_arch/src/features/users/domain/repositories/user_repository.dart';
import 'package:riverpod_with_clean_arch/src/features/users/domain/use_cases/get_all_users_use_case.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/use_cases/read_theme_use_case.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/use_cases/update_theme_use_case.dart';

@GenerateMocks([
  ConnectionService,
  HttpService,
  StorageService,
  UserDataSource,
  UserRepository,
  GetAllUsersUseCase,
  SettingDataSource,
  SettingRepository,
  ReadThemeUseCase,
  UpdateThemeUseCase,
])
void main() {}
