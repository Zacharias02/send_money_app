import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:send_money_app/core/common/app_constants.dart';
import 'package:send_money_app/core/common/exceptions.dart';
import 'package:send_money_app/core/common/failure.dart';
import 'package:send_money_app/features/authentication/data/repositories/auth_local_repository_impl.dart';
import 'package:send_money_app/features/authentication/domain/params/auth_params.dart';

import '../../../../mocks/core_mock.mocks.dart';

void main() {
  late MockAuthLocalDataSource mockDataSource;
  late AuthLocalRepositoryImpl repository;

  const validEmail = AppConstants.kTmpEmail;
  const validPassword = AppConstants.kTmpPassword;
  const invalidEmail = 'wrong@example.com';
  const invalidPassword = 'wrong123';

  setUp(() {
    mockDataSource = MockAuthLocalDataSource();
    repository = AuthLocalRepositoryImpl(mockDataSource);
  });

  group('signIn', () {
    test('should return Right(null) on valid credentials', () async {
      when(
        mockDataSource.saveAuthSession(isAuthenticated: true),
      ).thenAnswer((_) async => Future.value());

      final result = await repository.signIn(
        AuthParams(email: validEmail, password: validPassword),
      );

      expect(result, Right(null));
      verify(mockDataSource.saveAuthSession(isAuthenticated: true)).called(1);
    });

    test(
      'should return Left(NoDataFoundFailure) on invalid credentials',
      () async {
        final result = await repository.signIn(
          AuthParams(email: invalidEmail, password: invalidPassword),
        );

        expect(result, isA<Left>());
        expect(result.fold((l) => l, (_) => null), isA<NoDataFoundFailure>());
      },
    );

    test(
      'should return LocalStorageFailure on LocalStorageException',
      () async {
        when(
          mockDataSource.saveAuthSession(isAuthenticated: true),
        ).thenThrow(LocalStorageException(message: 'storage failed'));

        final result = await repository.signIn(
          AuthParams(email: validEmail, password: validPassword),
        );

        expect(result.fold((l) => l, (_) => null), isA<LocalStorageFailure>());
      },
    );

    test(
      'should return UnknownFailure when an unknown error occurs during signIn',
      () async {
        when(
          mockDataSource.saveAuthSession(isAuthenticated: true),
        ).thenThrow(Exception('Unexpected error'));

        final result = await repository.signIn(
          AuthParams(email: validEmail, password: validPassword),
        );

        expect(result.fold((l) => l, (_) => null), isA<UnknownFailure>());
      },
    );
  });

  group('isSessionActive', () {
    test('should return Right(true)', () async {
      when(mockDataSource.getAuthSession()).thenAnswer((_) async => true);

      final result = await repository.isSessionActive();

      expect(result, Right(true));
      verify(mockDataSource.getAuthSession()).called(1);
    });

    test(
      'should return LocalStorageFailure on LocalStorageException',
      () async {
        when(
          mockDataSource.getAuthSession(),
        ).thenThrow(LocalStorageException(message: 'read failed'));

        final result = await repository.isSessionActive();

        expect(result.fold((l) => l, (_) => null), isA<LocalStorageFailure>());
      },
    );

    test(
      'should return UnknownFailure when an unknown error occurs during isSessionActive',
      () async {
        when(
          mockDataSource.getAuthSession(),
        ).thenThrow(Exception('Unknown error'));

        final result = await repository.isSessionActive();

        expect(result.fold((l) => l, (_) => null), isA<UnknownFailure>());
      },
    );
  });

  group('signOut', () {
    test('should return Right(null) on successful logout', () async {
      when(
        mockDataSource.deleteAuthSession(),
      ).thenAnswer((_) async => Future.value());

      final result = await repository.signOut();

      expect(result, Right(null));
      verify(mockDataSource.deleteAuthSession()).called(1);
    });

    test(
      'should return LocalStorageFailure on LocalStorageException',
      () async {
        when(
          mockDataSource.deleteAuthSession(),
        ).thenThrow(LocalStorageException(message: 'delete failed'));

        final result = await repository.signOut();

        expect(result.fold((l) => l, (_) => null), isA<LocalStorageFailure>());
      },
    );

    test(
      'should return UnknownFailure when an unknown error occurs during signOut',
      () async {
        when(
          mockDataSource.deleteAuthSession(),
        ).thenThrow(Exception('Unexpected delete error'));

        final result = await repository.signOut();

        expect(result.fold((l) => l, (_) => null), isA<UnknownFailure>());
      },
    );
  });
}
