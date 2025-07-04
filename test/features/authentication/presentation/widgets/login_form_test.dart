import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money_app/core/di/injector.dart';
import 'package:send_money_app/core/presentation/widgets/app_scaffold.dart';
import 'package:send_money_app/features/authentication/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:send_money_app/features/authentication/presentation/widgets/login_form.dart';

import '../../../../mocks/core_mock.mocks.dart';

void main() {
  late MockAuthCubit mockAuthCubit;

  setUp(() {
    mockAuthCubit = MockAuthCubit();

    // Register the mock cubit in getIt for LoginForm to retrieve it
    if (!getIt.isRegistered<AuthCubit>()) {
      getIt.registerSingleton<AuthCubit>(mockAuthCubit);
    }

    // Default stubs for cubit state and stream
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
      home: AppScaffold(
        body: BlocProvider<AuthCubit>.value(
          value: mockAuthCubit, // Provide the mocked cubit here
          child: const LoginForm(),
        ),
      ),
    );
  }

  testWidgets('renders email and password fields and sign-in button', (
    tester,
  ) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(TextFormField), findsNWidgets(2)); // Email and Password
    expect(find.text('Sign In'), findsOneWidget);
  });

  testWidgets('validates empty email and password fields', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Tap sign-in button without entering anything
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('Email address is required.'), findsOneWidget);
    expect(find.text('Password is required.'), findsOneWidget);
  });

  testWidgets('calls signIn on cubit when form is valid', (tester) async {
    when(mockAuthCubit.signIn(any, any)).thenAnswer((_) async {});

    await tester.pumpWidget(createWidgetUnderTest());

    // Enter valid email and password
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'test@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');

    // Tap sign-in button
    await tester.tap(find.text('Sign In'));
    await tester.pump();

    // Verify cubit.signIn called with correct parameters
    verify(mockAuthCubit.signIn('test@example.com', 'password123')).called(1);
  });

  testWidgets('shows error dialog on failure state', (tester) async {
    // Stream emits failure state with error message
    when(mockAuthCubit.stream).thenAnswer(
      (_) => Stream.value(AuthState.failure('Invalid credentials')),
    );
    when(
      mockAuthCubit.state,
    ).thenReturn(AuthState.failure('Invalid credentials'));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Start listening to cubit stream

    // Wait for dialog to appear
    await tester.pumpAndSettle();

    expect(find.text('Invalid credentials'), findsOneWidget);
    expect(find.byType(Dialog), findsOneWidget);
  });
}
