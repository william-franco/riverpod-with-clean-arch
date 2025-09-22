import 'package:go_router/go_router.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/presentation/routes/setting_routes.dart';
import 'package:riverpod_with_clean_arch/src/features/users/presentation/routes/user_routes.dart';

class Routes {
  static String get home => UserRoutes.users;

  GoRouter get routes => _routes;

  final GoRouter _routes = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: home,
    routes: [...UserRoutes().routes, ...SettingRoutes().routes],
  );
}
