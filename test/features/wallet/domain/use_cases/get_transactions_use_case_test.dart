import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:send_money_app/core/common/failure.dart';
import 'package:send_money_app/features/wallet/domain/entities/wallet_entity/wallet_entity.dart';
import 'package:send_money_app/features/wallet/domain/use_cases/get_transactions_use_case.dart';

import '../../../../mocks/core_mock.mocks.dart';

void main() {
  late GetTransactionsUseCase useCase;
  late MockWalletRemoteRepository mockRepository;

  setUp(() {
    mockRepository = MockWalletRemoteRepository();
    useCase = GetTransactionsUseCase(mockRepository);
  });

  test('should return list of WalletEntity on success', () async {
    final expectedData = [
      WalletEntity(
        id: '1',
        amount: 100.0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    when(
      mockRepository.getTransactions(),
    ).thenAnswer((_) async => Right(expectedData));

    final result = await useCase();

    expect(result, Right(expectedData));
    verify(mockRepository.getTransactions()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure on error', () async {
    final failure = ServerFailure(
      status: '500',
      message: 'Internal Server Error',
      statusCode: 500,
    );

    when(
      mockRepository.getTransactions(),
    ).thenAnswer((_) async => Left(failure));

    final result = await useCase();

    expect(result, Left(failure));
    verify(mockRepository.getTransactions()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
