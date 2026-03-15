import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_with_clean_arch/src/common/state_management/state_management.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/domain/entities/setting_entity.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/presentation/view_models/setting_view_model.dart';

class SettingView extends StatelessWidget {
  final SettingViewModel settingViewModel;

  const SettingView({super.key, required this.settingViewModel});

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationIcon: const FlutterLogo(),
      applicationName: 'Riverpod With Clean Arch',
      applicationVersion: 'Version 1.0.0',
      applicationLegalese: '\u{a9} 2025 William Franco',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.brightness_6_outlined),
              title: const Text('Dark theme'),
              trailing: StateBuilderWidget<SettingViewModel, SettingEntity>(
                viewModel: settingViewModel,
                builder: (context, settingModel) {
                  return Switch(
                    value: settingModel.isDarkTheme,
                    onChanged: (bool isDarkTheme) {
                      settingViewModel.changeTheme(isDarkTheme: isDarkTheme);
                    },
                  );
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                _showAboutDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
