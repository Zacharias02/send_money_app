import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money_app/core/di/injector.dart';
import 'package:send_money_app/features/authentication/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:send_money_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:send_money_app/features/splash/presentation/screens/splash_screen.dart';
import 'package:send_money_app/features/wallet/presentation/screens/wallet_screen.dart';
import 'package:send_money_app/core/presentation/widgets/app_logo.dart';
import 'package:send_money_app/core/presentation/widgets/app_progress_indicator.dart';

import '../../../../mocks/core_mock.mocks.dart';

void main() {
  late MockAuthCubit mockAuthCubit;

  setUp(() {
    mockAuthCubit = MockAuthCubit();

    // Register the mock cubit in getIt for LoginForm to retrieve it
    if (!getIt.isRegistered<AuthCubit>()) {
      getIt.registerSingleton<AuthCubit>(mockAuthCubit);
    }

    // Stub initial state and stream with unauthenticated state by default
    when(mockAuthCubit.state).thenReturn(AuthState.init());
    when(mockAuthCubit.stream).thenAnswer((_) => Stream<AuthState>.empty());
  });

  tearDown(() {
    if (getIt.isRegistered<AuthCubit>()) {
      getIt.unregister<AuthCubit>();
    }
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<AuthCubit>.value(
        value: mockAuthCubit,
        child: const SplashScreen(),
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/wallet': (context) => const WalletScreen(),
      },
    );
  }

  testWidgets('renders AppLogo and AppProgressIndicator', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(AppLogo), findsOneWidget);
    expect(find.byType(AppProgressIndicator), findsOneWidget);
  });

  testWidgets('navigates to WalletScreen if authenticated', (tester) async {
    // Prepare stream to emit authenticated state after a frame
    when(
      mockAuthCubit.stream,
    ).thenAnswer((_) => Stream.value(AuthState.success(isAuthenticated: true)));
    when(
      mockAuthCubit.state,
    ).thenReturn(AuthState.success(isAuthenticated: true));

    await tester.pumpWidget(createWidgetUnderTest());

    // BlocListener triggers navigation after the first frame, so pump and settle
    await tester.pumpAndSettle();

    expect(find.byType(WalletScreen), findsOneWidget);
    expect(find.byType(LoginScreen), findsNothing);
  });

  testWidgets('navigates to LoginScreen if NOT authenticated', (tester) async {
    // Prepare stream to emit unauthenticated state
    when(mockAuthCubit.stream).thenAnswer(
      (_) => Stream.value(AuthState.success(isAuthenticated: false)),
    );
    when(
      mockAuthCubit.state,
    ).thenReturn(AuthState.success(isAuthenticated: false));

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(WalletScreen), findsNothing);
  });
}
