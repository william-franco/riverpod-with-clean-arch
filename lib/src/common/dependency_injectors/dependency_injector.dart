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
final connectionService = Provider<ConnectionService>((ref) {
  final service = ConnectionServiceImpl();
  Future.microtask(() async {
    await service.checkConnection();
  });
  return service;
});

final httpService = Provider<HttpService>((ref) {
  return HttpServiceImpl();
});

final storageService = Provider<StorageService>((ref) {
  final service = StorageServiceImpl();
  Future.microtask(() async {
    await service.initStorage();
  });
  return service;
});

// Data Sources
final settingDataSource = Provider.autoDispose<SettingDataSource>((ref) {
  return SettingDataSourceImpl(storageService: ref.watch(storageService));
});

final userDataSource = Provider.autoDispose<UserDataSource>((ref) {
  return UserDataSourceImpl(
    connectionService: ref.watch(connectionService),
    httpService: ref.watch(httpService),
  );
});

// Repositories
final settingRepository = Provider.autoDispose<SettingRepository>((ref) {
  return SettingRepositoryImpl(settingDataSource: ref.watch(settingDataSource));
});

final userRepository = Provider.autoDispose<UserRepository>((ref) {
  return UserRepositoryImpl(userDataSource: ref.watch(userDataSource));
});

// Use Cases
final readThemeUseCase = Provider.autoDispose<ReadThemeUseCase>((ref) {
  return ReadThemeUseCaseImpl(settingRepository: ref.watch(settingRepository));
});

final updateThemeUseCase = Provider.autoDispose<UpdateThemeUseCase>((ref) {
  return UpdateThemeUseCaseImpl(
    settingRepository: ref.watch(settingRepository),
  );
});

final getAllUsersUseCase = Provider.autoDispose<GetAllUsersUseCase>((ref) {
  return GetAllUsersUseCaseImpl(userRepository: ref.watch(userRepository));
});

// ViewModels
final settingViewModelProv = ChangeNotifierProvider<SettingViewModel>((ref) {
  final viewModel = SettingViewModelImpl(
    readThemeUseCase: ref.watch(readThemeUseCase),
    updateThemeUseCase: ref.watch(updateThemeUseCase),
  );
  Future.microtask(() async {
    await Future.delayed(Duration.zero);
    await viewModel.getTheme();
  });
  return viewModel;
});

final userViewModelProv = ChangeNotifierProvider<UserViewModel>((ref) {
  return UserViewModelImpl(getAllUsersUseCase: ref.watch(getAllUsersUseCase));
});
