import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_with_clean_arch/src/common/dependency_injectors/dependency_injector.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/presentation/views/setting_view.dart';

class SettingRoutes {
  static String get setting => '/setting';

  List<GoRoute> get routes => _routes;

  final List<GoRoute> _routes = [
    GoRoute(
      path: setting,
      builder: (context, state) {
        return Consumer(
          builder: (context, ref, child) {
            return SettingView(
              settingViewModel: ref.read(settingViewModelProv),
            );
          },
        );
      },
    ),
  ];
}
