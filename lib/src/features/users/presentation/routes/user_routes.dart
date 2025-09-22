import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_with_clean_arch/src/common/dependency_injectors/dependency_injector.dart';
import 'package:riverpod_with_clean_arch/src/features/users/domain/entities/user_entity.dart';
import 'package:riverpod_with_clean_arch/src/features/users/presentation/views/user_detail_view.dart';
import 'package:riverpod_with_clean_arch/src/features/users/presentation/views/user_view.dart';

class UserRoutes {
  static String get users => '/users';
  static String get userDetail => '/users-detail';

  List<GoRoute> get routes => _routes;

  final List<GoRoute> _routes = [
    GoRoute(
      path: users,
      builder: (context, state) {
        return Consumer(
          builder: (context, ref, child) {
            return UserView(userViewModel: ref.read(userViewModelProv));
          },
        );
      },
    ),
    GoRoute(
      path: userDetail,
      builder: (context, state) {
        final UserEntity userEntity = state.extra as UserEntity;

        return UserDetailView(userEntity: userEntity);
      },
    ),
  ];
}
