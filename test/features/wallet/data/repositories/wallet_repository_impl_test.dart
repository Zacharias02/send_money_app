import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money_app/core/common/app_constants.dart';
import 'package:send_money_app/core/common/exceptions.dart';
import 'package:send_money_app/core/common/failure.dart';
import 'package:send_money_app/features/wallet/data/models/wallet_response_model/wallet_response_model.dart';
import 'package:send_money_app/features/wallet/data/repositories/wallet_remote_repository_impl.dart';

import '../../../../mocks/core_mock.mocks.dart';

void main() {
  late MockWalletRemoteDataSource mockDataSource;
  late WalletRemoteRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockWalletRemoteDataSource();
    repository = WalletRemoteRepositoryImpl(mockDataSource);
  });

  group('sendMoney', () {
    test('should return success message on success', () async {
      when(
        mockDataSource.sendMoney(amount: 1000.0),
      ).thenAnswer((_) async => Future.value());

      final result = await repository.sendMoney(amount: 1000.0);

      expect(result, Right(AppConstants.kSendMoneySuccess));
      verify(mockDataSource.sendMoney(amount: 1000.0)).called(1);
    });

    test('should return ServerFailure on HttpException', () async {
      when(mockDataSource.sendMoney(amount: 1000.0)).thenThrow(
        HttpException(
          status: 'Bad Request',
          message: 'Insufficient balance',
          statusCode: 400,
        ),
      );

      final result = await repository.sendMoney(amount: 1000.0);

      expect(result, isA<Left<Failure, String>>());
      expect(result.fold((l) => l, (_) => null), isA<ServerFailure>());
    });

    test('should return UnknownFailure on unknown exception', () async {
      when(
        mockDataSource.sendMoney(amount: 1000.0),
      ).thenThrow(Exception('Unknown'));

      final result = await repository.sendMoney(amount: 1000.0);

      result.fold(
        (failure) {
          expect(failure, isA<UnknownFailure>());
          expect(
            (failure as UnknownFailure).message,
            AppConstants.kUnknownError,
          );
        },
        (_) => fail('Expected failure, but got success'),
      );
    });
  });

  group('getTransactions', () {
    test('should return list of WalletEntity on success', () async {
      final mockModels = [
        WalletResponseModel(
          id: '1',
          amount: 100.0,
          createdAt: DateTime.parse('2024-01-01'),
          updatedAt: DateTime.parse('2024-01-01'),
        ),
        WalletResponseModel(
          id: '2',
          amount: 200.0,
          createdAt: DateTime.parse('2024-01-02'),
          updatedAt: DateTime.parse('2024-01-02'),
        ),
      ];

      when(
        mockDataSource.getTransactions(),
      ).thenAnswer((_) async => mockModels);

      final result = await repository.getTransactions();

      expect(result.isRight(), true);
      final entities = result.getOrElse(() => []);
      expect(entities.first.id, '1');
      expect(entities.length, 2);
    });

    test('should return ServerFailure on HttpException', () async {
      when(mockDataSource.getTransactions()).thenThrow(
        HttpException(
          status: 'Internal Error',
          message: 'Server crashed',
          statusCode: 500,
        ),
      );

      final result = await repository.getTransactions();

      result.fold(
        (failure) {
          expect(failure, isA<ServerFailure>());
          final serverFailure = failure as ServerFailure;
          expect(serverFailure.status, 'Internal Error');
          expect(serverFailure.message, 'Server crashed');
          expect(serverFailure.statusCode, 500);
        },
        (_) => fail('Expected ServerFailure, but got success'),
      );
    });

    test('should return UnknownFailure on unknown exception', () async {
      when(
        mockDataSource.getTransactions(),
      ).thenThrow(Exception('Something went wrong'));

      final result = await repository.getTransactions();

      expect(result.isLeft(), true);

      result.fold(
        (failure) {
          expect(failure, isA<UnknownFailure>());
          expect(
            (failure as UnknownFailure).message,
            AppConstants.kUnknownError,
          );
        },
        (_) => fail('Expected failure, but got success'),
      );
    });
  });
}
