import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money_app/core/di/injector.dart';
import 'package:send_money_app/features/authentication/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:send_money_app/features/wallet/presentation/cubits/wallet_cubit/wallet_cubit.dart';
import 'package:send_money_app/features/wallet/presentation/screens/send_money_screen.dart';
import 'package:send_money_app/features/wallet/presentation/screens/transaction_history_screen.dart';
import 'package:send_money_app/features/wallet/presentation/screens/wallet_screen.dart';

import '../../../../mocks/core_mock.mocks.dart';

void main() {
  late MockAuthCubit mockAuthCubit;
  late MockWalletCubit mockWalletCubit;

  setUp(() {
    mockAuthCubit = MockAuthCubit();
    mockWalletCubit = MockWalletCubit();

    getIt.registerSingleton<AuthCubit>(mockAuthCubit);
    getIt.registerSingleton<WalletCubit>(mockWalletCubit);

    when(mockWalletCubit.state).thenReturn(WalletState.init());
    when(
      mockWalletCubit.stream,
    ).thenAnswer((_) => Stream.value(WalletState.init()));
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets('WalletScreen displays buttons and calls signOut', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: WalletScreen()),
    );

    // Verify UI elements
    expect(find.text('Welcome back! 👋'), findsOneWidget);
    expect(find.text('Send Money'), findsOneWidget);
    expect(find.text('View Transactions'), findsOneWidget);

    // Tap logout icon
    await tester.tap(find.byIcon(Icons.logout));
    verify(mockAuthCubit.signOut()).called(1);
  });

  testWidgets('Tapping Send Money navigates to SendMoneyScreen', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: WalletScreen()),
    );

    await tester.tap(find.text('Send Money'));
    await tester.pumpAndSettle();

    expect(find.byType(SendMoneyScreen), findsOneWidget);
  });

  testWidgets(
    'Tapping View Transactions navigates to TransactionHistoryScreen',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: WalletScreen()),
      );

      await tester.tap(find.text('View Transactions'));
      await tester.pumpAndSettle();

      expect(find.byType(TransactionHistoryScreen), findsOneWidget);
    },
  );
}
