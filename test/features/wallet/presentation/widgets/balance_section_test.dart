import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:send_money_app/core/presentation/widgets/app_scaffold.dart';
import 'package:send_money_app/features/wallet/presentation/widgets/balance_section.dart';

void main() {
  testWidgets('BalanceSection toggles visibility', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: AppScaffold(body: BalanceSection())),
    );

    // Initially masked
    expect(find.textContaining('₱'), findsOneWidget);
    expect(find.textContaining('*'), findsWidgets);

    // Tap to unmask
    await tester.tap(find.byKey(const Key('toggle_button')));
    await tester.pump();

    // Now unmasked
    expect(find.text('₱ 200,000.00'), findsOneWidget);
    expect(find.textContaining('*'), findsNothing);
  });
}
