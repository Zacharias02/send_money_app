import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:send_money_app/core/common/app_theme.dart';
import 'package:send_money_app/core/presentation/widgets/app_scaffold.dart';

void main() {
  group('AppScaffold', () {
    testWidgets('renders body widget without AppBar when title is null', (
      tester,
    ) async {
      const testKey = Key('body');

      await tester.pumpWidget(
        const MaterialApp(
          home: AppScaffold(
            body: SizedBox(key: testKey),
          ),
        ),
      );

      expect(find.byKey(testKey), findsOneWidget);
      expect(find.byType(AppBar), findsNothing);
    });

    testWidgets('renders AppBar with title when appBarTitle is provided', (
      tester,
    ) async {
      const testTitle = 'Test Title';

      await tester.pumpWidget(
        const MaterialApp(
          home: AppScaffold(
            appBarTitle: testTitle,
            body: SizedBox(),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text(testTitle), findsOneWidget);
    });

    testWidgets('uses correct background color from AppTheme', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AppScaffold(
            appBarTitle: 'Check BG',
            body: SizedBox(),
          ),
        ),
      );

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, AppTheme.kWhiteColor);
    });
  });
}
