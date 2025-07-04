import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:send_money_app/core/presentation/widgets/app_bottom_sheet.dart';

void main() {
  group('AppBottomSheet', () {
    testWidgets('renders success icon and message when isSuccessful is true', (
      tester,
    ) async {
      const message = 'Success!';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppBottomSheet(message: message, isSuccessful: true),
          ),
        ),
      );

      expect(find.text(message), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.byIcon(Icons.close), findsNothing);
    });

    testWidgets('renders error icon and message when isSuccessful is false', (
      tester,
    ) async {
      const message = 'Something went wrong.';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AppBottomSheet(message: message, isSuccessful: false),
          ),
        ),
      );

      expect(find.text(message), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
      expect(find.byIcon(Icons.check), findsNothing);
    });
  });
}
