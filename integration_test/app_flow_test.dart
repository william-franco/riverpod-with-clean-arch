import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:riverpod_with_clean_arch/main.dart' as app;

/// CI: navigation smoke does not require JSONPlaceholder / live network.

bool _usersShellReady() {
  return find.text('Users').evaluate().isNotEmpty ||
      find.text('List is empty.').evaluate().isNotEmpty ||
      find.textContaining('Error:').evaluate().isNotEmpty ||
      find.byType(ListTile).evaluate().isNotEmpty;
}

Future<void> _waitForUsersShell(WidgetTester tester) async {
  for (var i = 0; i < 30; i++) {
    if (_usersShellReady()) return;
    await tester.pump(const Duration(seconds: 1));
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('opens settings from users screen', (tester) async {
    app.main();
    await _waitForUsersShell(tester);
    expect(_usersShellReady(), isTrue);

    final settings = find.byIcon(Icons.settings_outlined);
    expect(settings, findsWidgets);
    await tester.ensureVisible(settings.first);
    await tester.tap(settings.first);
    await tester.pumpAndSettle(const Duration(seconds: 15));

    expect(find.text('Settings'), findsOneWidget);
  });
}