import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_with_clean_arch/src/common/states/state.dart';
import 'package:riverpod_with_clean_arch/src/common/widgets/refresh_button_widget.dart';
import 'package:riverpod_with_clean_arch/src/common/widgets/refresh_indicator_widget.dart';
import 'package:riverpod_with_clean_arch/src/common/widgets/skeleton_refresh_widget.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/presentation/routes/setting_routes.dart';
import 'package:riverpod_with_clean_arch/src/features/users/presentation/routes/user_routes.dart';
import 'package:riverpod_with_clean_arch/src/features/users/presentation/view_models/user_view_model.dart';

class UserView extends StatefulWidget {
  final UserViewModel userViewModel;

  const UserView({super.key, required this.userViewModel});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _getAllUsers();
    });
  }

  Future<void> _getAllUsers() async {
    await widget.userViewModel.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Users'),
        actions: [
          RefreshButtonWidget(
            onPressed: () async {
              await _getAllUsers();
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              context.push(SettingRoutes.setting);
            },
          ),
        ],
      ),
      body: Center(
        child: RefreshIndicatorWidget(
          onRefresh: () async {
            await _getAllUsers();
          },
          child: ListenableBuilder(
            listenable: widget.userViewModel,
            builder: (context, child) {
              return switch (widget.userViewModel.userState) {
                InitialState() => const Text('List is empty.'),
                LoadingState() => ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return const SkeletonRefreshWidget();
                  },
                ),
                SuccessState(data: final users) => ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = users[index];
                    return InkWell(
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(user.name![0].toUpperCase()),
                          ),
                          title: Text(user.name ?? ''),
                          subtitle: Text(user.email ?? ''),
                        ),
                      ),
                      onTap: () {
                        context.push(UserRoutes.userDetail, extra: user);
                      },
                    );
                  },
                ),
                ErrorState(message: final message) => Text(message),
              };
            },
          ),
        ),
      ),
    );
  }
}
