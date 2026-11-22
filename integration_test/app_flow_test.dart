import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:riverpod_with_clean_arch/main.dart' as app;

/// CI: navigation smoke does not require JSONPlaceholder / live network.

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

bool _usersScreenInteractable() {
  if (find.text('Users').evaluate().isEmpty) return false;
  final settings = find.descendant(
    of: find.byType(AppBar),
    matching: find.byIcon(Icons.settings_outlined),
  );
  return settings.evaluate().isNotEmpty;
}

Future<void> _waitForRouteTitle(WidgetTester tester, String title) async {
  for (var i = 0; i < 30; i++) {
    if (find.text(title).evaluate().isNotEmpty) return;
    await tester.pump(const Duration(milliseconds: 200));
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('opens settings from users screen', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 800));
    app.main();
    await _waitForUsersSettled(tester);
    if (!_usersBodySettled()) {
      for (var i = 0; i < 30; i++) {
        if (_usersScreenInteractable()) break;
        await tester.pump(const Duration(milliseconds: 500));
      }
    }
    expect(_usersScreenInteractable(), isTrue);

    final settings = find.descendant(
      of: find.byType(AppBar),
      matching: find.byIcon(Icons.settings_outlined),
    );
    await tester.ensureVisible(settings.first);
    await tester.tap(settings.first);
    await _waitForRouteTitle(tester, 'Settings');

    expect(find.text('Settings'), findsOneWidget);
  });
}