import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:riverpod_with_clean_arch/main.dart' as app;

/// CI: navigation smoke does not require JSONPlaceholder / live network.

const _settingsKey = Key('e2e_open_settings');

bool _usersBodySettled() {
  return find.textContaining('Error:').evaluate().isNotEmpty ||
      find.text('List is empty.').evaluate().isNotEmpty ||
      find.byType(ListTile).evaluate().isNotEmpty;
}

Future<void> _waitForUsersSettled(WidgetTester tester) async {
  for (var i = 0; i < 90; i++) {
    if (_usersBodySettled()) return;
    await tester.pump(const Duration(milliseconds: 500));
  }
}

Future<void> _waitForRouteTitle(WidgetTester tester, String title) async {
  for (var i = 0; i < 60; i++) {
    if (find.text(title).evaluate().isNotEmpty) return;
    await tester.pump(const Duration(milliseconds: 300));
  }
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  testWidgets('opens settings from users screen', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 800));
    app.main();
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(seconds: 2)),
    );
    await _waitForUsersSettled(tester);

    final settings = find.byKey(_settingsKey);
    expect(settings, findsOneWidget);
    await tester.ensureVisible(settings);
    await tester.tap(settings);
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 800)),
    );
    await _waitForRouteTitle(tester, 'Settings');

    expect(find.text('Settings'), findsOneWidget);
  });
}