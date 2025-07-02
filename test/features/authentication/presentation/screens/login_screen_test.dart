import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import 'package:send_money_app/features/authentication/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:send_money_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:send_money_app/core/presentation/widgets/app_logo.dart';
import 'package:send_money_app/features/authentication/presentation/widgets/login_form.dart';

import '../../../../mocks/core_mock.mocks.dart';

void main() {
  late MockAuthCubit mockAuthCubit;

  final getIt = GetIt.instance;

  setUp(() {
    mockAuthCubit = MockAuthCubit();

    // Register the mock cubit into getIt for the test
    if (!getIt.isRegistered<AuthCubit>()) {
      getIt.registerSingleton<AuthCubit>(mockAuthCubit);
    }

    // Stub initial state if needed
    when(mockAuthCubit.state).thenReturn(AuthState.init());
    when(mockAuthCubit.stream).thenAnswer((_) => Stream<AuthState>.empty());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<AuthCubit>.value(
        value: mockAuthCubit,
        child: const LoginScreen(),
      ),
    );
  }

  testWidgets('renders LoginScreen with logo, title and login form', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Check AppLogo widget
    expect(find.byType(AppLogo), findsOneWidget);

    // Check title text
    expect(find.text('Send money with ease!'), findsOneWidget);

    // Check LoginForm widget
    expect(find.byType(LoginForm), findsOneWidget);
  });
}
