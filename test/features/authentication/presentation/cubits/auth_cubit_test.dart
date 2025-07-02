import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:send_money_app/core/common/enums/process_status.dart';

import 'package:send_money_app/core/common/failure.dart';
import 'package:send_money_app/features/authentication/presentation/cubits/auth_cubit/auth_cubit.dart';

import '../../../../mocks/core_mock.mocks.dart';

void main() {
  late MockSignInUseCase mockSignInUseCase;
  late MockSignOutUseCase mockSignOutUseCase;
  late MockCheckSessionUseCase mockCheckSessionUseCase;
  late AuthCubit authCubit;

  const tEmail = 'test@example.com';
  const tPassword = 'password123';

  setUp(() {
    mockSignInUseCase = MockSignInUseCase();
    mockSignOutUseCase = MockSignOutUseCase();
    mockCheckSessionUseCase = MockCheckSessionUseCase();
    authCubit = AuthCubit(
      mockSignInUseCase,
      mockCheckSessionUseCase,
      mockSignOutUseCase,
    );
  });

  tearDown(() {
    authCubit.close();
  });

  group('signIn', () {
    blocTest<AuthCubit, AuthState>(
      'emits [loading, success] on successful sign in',
      build: () {
        when(mockSignInUseCase.call(any)).thenAnswer((_) async => Right(null));
        return authCubit;
      },
      act: (cubit) => cubit.signIn(tEmail, tPassword),
      expect: () => [
        AuthState.loading(),
        AuthState.success(isAuthenticated: true),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, failure] on failed sign in',
      build: () {
        when(mockSignInUseCase.call(any)).thenAnswer(
          (_) async => Left(UnknownFailure(message: 'Sign-in failed')),
        );
        return authCubit;
      },
      act: (cubit) => cubit.signIn(tEmail, tPassword),
      expect: () => [
        AuthState.loading(),
        AuthState.failure('Sign-in failed'),
      ],
    );
  });

  group('checkSession', () {
    blocTest<AuthCubit, AuthState>(
      'emits [loading, success(true)] if session is active',
      build: () {
        when(
          mockCheckSessionUseCase.call(),
        ).thenAnswer((_) async => Right(true));
        return authCubit;
      },
      act: (cubit) => cubit.checkSession(),
      expect: () => [
        AuthState.loading(),
        AuthState.success(isAuthenticated: true),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, success(false)] if session is not active',
      build: () {
        when(
          mockCheckSessionUseCase.call(),
        ).thenAnswer((_) async => Right(false));
        return authCubit;
      },
      act: (cubit) => cubit.checkSession(),
      expect: () => [
        AuthState.loading(),
        AuthState.success(isAuthenticated: false),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, failure] on session check error',
      build: () {
        when(mockCheckSessionUseCase.call()).thenAnswer(
          (_) async => Left(UnknownFailure(message: 'Session error')),
        );
        return authCubit;
      },
      act: (cubit) => cubit.checkSession(),
      expect: () => [
        AuthState.loading(),
        AuthState.failure('Session error'),
      ],
    );
  });

  group('signOut', () {
    blocTest<AuthCubit, AuthState>(
      'emits [loading, success(false)] on successful sign out',
      build: () {
        when(mockSignOutUseCase.call()).thenAnswer((_) async => Right(null));
        return authCubit;
      },
      act: (cubit) => cubit.signOut(),
      expect: () => [
        AuthState.loading(),
        AuthState.success(isAuthenticated: false),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, failure] on failed sign out',
      build: () {
        when(mockSignOutUseCase.call()).thenAnswer(
          (_) async => Left(UnknownFailure(message: 'Sign out failed')),
        );
        return authCubit;
      },
      act: (cubit) => cubit.signOut(),
      expect: () => [
        AuthState.loading(),
        AuthState.failure('Sign out failed'),
      ],
    );
  });

  group('AuthState custom getters', () {
    test('init state should not be loading, successful, or failed', () {
      final state = AuthState.init();

      expect(state.status, ProcessStatus.none);
      expect(state.isLoading, isFalse);
      expect(state.isSuccessful, isFalse);
      expect(state.isFailed, isFalse);
    });

    test('loading state should set isLoading = true', () {
      final state = AuthState.loading();

      expect(state.status, ProcessStatus.inProgress);
      expect(state.isLoading, isTrue);
      expect(state.isSuccessful, isFalse);
      expect(state.isFailed, isFalse);
    });

    test('success state should set isSuccessful = true', () {
      final state = AuthState.success(isAuthenticated: true);

      expect(state.status, ProcessStatus.successful);
      expect(state.isLoading, isFalse);
      expect(state.isSuccessful, isTrue);
      expect(state.isFailed, isFalse);
    });

    test('failure state should set isFailed = true', () {
      final state = AuthState.failure('error');

      expect(state.status, ProcessStatus.failed);
      expect(state.errorMessage, 'error');
      expect(state.isLoading, isFalse);
      expect(state.isSuccessful, isFalse);
      expect(state.isFailed, isTrue);
    });
  });
}
