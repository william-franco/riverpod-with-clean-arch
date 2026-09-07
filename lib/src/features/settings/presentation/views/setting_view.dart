import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_with_clean_arch/src/common/patterns/state_pattern.dart';
import 'package:riverpod_with_clean_arch/src/common/state_management/state_management.dart';
import 'package:riverpod_with_clean_arch/src/features/settings/presentation/presentation.dart';

class SettingView extends StatefulWidget {
  final SettingViewModel settingViewModel;

  const SettingView({super.key, required this.settingViewModel});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await widget.settingViewModel.getTheme();
    });
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationIcon: const FlutterLogo(),
      applicationName: 'Riverpod With Clean Arch',
      applicationVersion: 'Version 1.0.0',
      applicationLegalese: '\u{a9} 2025 William Franco',
    );
  }

  bool _isDarkTheme(SettingsState state) => switch (state) {
        SuccessState(data: final setting) => setting.isDarkTheme,
        _ => false,
      };

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
              trailing: StateBuilderWidget<SettingViewModel, SettingsState>(
                viewModel: widget.settingViewModel,
                builder: (context, settingState) {
                  return Switch(
                    value: _isDarkTheme(settingState),
                    onChanged: (bool isDarkTheme) {
                      widget.settingViewModel.changeTheme(
                        isDarkTheme: isDarkTheme,
                      );
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
