import 'package:mockito/annotations.dart';
import 'package:riverpod_with_clean_arch/src/common/services/storage_service.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/data/data_sources/setting_data_source.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/repositories/setting_repository.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/use_cases/read_theme_use_case.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/use_cases/update_theme_use_case.dart';

@GenerateMocks([
  StorageService,
  SettingDataSource,
  SettingRepository,
  ReadThemeUseCase,
  UpdateThemeUseCase,
])
void main() {}
