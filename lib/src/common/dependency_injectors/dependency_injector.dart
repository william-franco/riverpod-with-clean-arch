import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod_with_clean_arch/src/common/services/connection_service.dart';
import 'package:riverpod_with_clean_arch/src/common/services/http_service.dart';
import 'package:riverpod_with_clean_arch/src/common/services/storage_service.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/data/data_sources/setting_data_source.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/data/data_sources/setting_data_source_impl.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/data/repositories/setting_repository_impl.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/repositories/setting_repository.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/usecases/read_theme_use_case.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/usecases/update_theme_use_case.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/presentation/view_models/setting_view_model.dart';
import 'package:riverpod_with_clean_arch/src/features/users/data/data_sources/user_data_source.dart';
import 'package:riverpod_with_clean_arch/src/features/users/data/data_sources/user_data_source_impl.dart';
import 'package:riverpod_with_clean_arch/src/features/users/data/repositories/user_repository_impl.dart';
import 'package:riverpod_with_clean_arch/src/features/users/domain/repositories/user_repository.dart';
import 'package:riverpod_with_clean_arch/src/features/users/domain/usecases/get_all_users_use_case.dart';
import 'package:riverpod_with_clean_arch/src/features/users/presentation/view_models/user_view_model.dart';

// Services
final connectionServiceProvider = Provider<ConnectionService>((ref) {
  return ConnectionServiceImpl();
});

final httpServiceProvider = Provider<HttpService>((ref) {
  return HttpServiceImpl();
});

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageServiceImpl();
});

// Data Sources
final settingDataSourceProvider = Provider.autoDispose<SettingDataSource>((
  ref,
) {
  final storageService = ref.watch(storageServiceProvider);
  return SettingDataSourceImpl(storageService: storageService);
});

final userDataSourceProvider = Provider.autoDispose<UserDataSource>((ref) {
  final connectionService = ref.watch(connectionServiceProvider);
  final httpService = ref.watch(httpServiceProvider);
  return UserDataSourceImpl(
    connectionService: connectionService,
    httpService: httpService,
  );
});

// Repositories
final settingRepositoryProvider = Provider.autoDispose<SettingRepository>((
  ref,
) {
  final settingDataSource = ref.watch(settingDataSourceProvider);
  return SettingRepositoryImpl(settingDataSource: settingDataSource);
});

final userRepositoryProvider = Provider.autoDispose<UserRepository>((ref) {
  final userDataSource = ref.watch(userDataSourceProvider);
  return UserRepositoryImpl(userDataSource: userDataSource);
});

// Use Cases
final readThemeUseCaseProvider = Provider.autoDispose<ReadThemeUseCase>((ref) {
  final settingRepository = ref.watch(settingRepositoryProvider);
  return ReadThemeUseCaseImpl(settingRepository: settingRepository);
});

final updateThemeUseCaseProvider = Provider.autoDispose<UpdateThemeUseCase>((
  ref,
) {
  final settingRepository = ref.watch(settingRepositoryProvider);
  return UpdateThemeUseCaseImpl(settingRepository: settingRepository);
});

final getAllUsersUseCaseProvider = Provider.autoDispose<GetAllUsersUseCase>((
  ref,
) {
  final userRepository = ref.watch(userRepositoryProvider);
  return GetAllUsersUseCaseImpl(userRepository: userRepository);
});

// ViewModels
final settingViewModelProvider = ChangeNotifierProvider<SettingViewModel>((
  ref,
) {
  final readThemeUseCase = ref.watch(readThemeUseCaseProvider);
  final updateThemeUseCase = ref.watch(updateThemeUseCaseProvider);
  return SettingViewModelImpl(
    readThemeUseCase: readThemeUseCase,
    updateThemeUseCase: updateThemeUseCase,
  );
});

final userViewModelProvider = ChangeNotifierProvider<UserViewModel>((ref) {
  final getAllUsersUseCase = ref.watch(getAllUsersUseCaseProvider);
  return UserViewModelImpl(getAllUsersUseCase: getAllUsersUseCase);
});

/// Init dependencies asynchronously.
final appBootstrapProvider = FutureProvider<void>((ref) async {
  final storageService = ref.read(storageServiceProvider);
  final connectionService = ref.read(connectionServiceProvider);
  final settingViewModel = ref.read(settingViewModelProvider);

  await Future.wait([
    storageService.initStorage(),
    connectionService.checkConnection(),
  ]);

  await settingViewModel.getTheme();
});
