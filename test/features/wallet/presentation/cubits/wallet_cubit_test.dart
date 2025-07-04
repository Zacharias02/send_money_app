import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money_app/core/common/enums/process_status.dart';
import 'package:send_money_app/core/common/failure.dart';
import 'package:send_money_app/features/wallet/domain/entities/wallet_entity/wallet_entity.dart';
import 'package:send_money_app/features/wallet/presentation/cubits/wallet_cubit/wallet_cubit.dart';

import '../../../../mocks/core_mock.mocks.dart';

void main() {
  late MockSendMoneyUseCase mockSendMoneyUseCase;
  late MockGetTransactionsUseCase mockGetTransactionsUseCase;
  late WalletCubit walletCubit;

  setUp(() {
    mockSendMoneyUseCase = MockSendMoneyUseCase();
    mockGetTransactionsUseCase = MockGetTransactionsUseCase();
    walletCubit = WalletCubit(mockSendMoneyUseCase, mockGetTransactionsUseCase);
  });

  group('sendMoney', () {
    const testAmount = '1000';
    const successMessage = 'Money sent successfully';

    blocTest<WalletCubit, WalletState>(
      'emits [loading, success] when sending money succeeds',
      build: () {
        when(
          mockSendMoneyUseCase.call(double.parse(testAmount)),
        ).thenAnswer((_) async => const Right(successMessage));
        return walletCubit;
      },
      act: (cubit) => cubit.sendMoney(testAmount),
      expect: () => [
        WalletState.loading(),
        WalletState.success(message: successMessage),
      ],
      verify: (_) {
        verify(mockSendMoneyUseCase.call(double.parse(testAmount))).called(1);
      },
    );

    blocTest<WalletCubit, WalletState>(
      'emits [loading, failure] when sending money fails',
      build: () {
        when(mockSendMoneyUseCase.call(double.parse(testAmount))).thenAnswer(
          (_) async => Left(UnknownFailure(message: 'Something went wrong')),
        );
        return walletCubit;
      },
      act: (cubit) => cubit.sendMoney(testAmount),
      expect: () => [
        WalletState.loading(),
        WalletState.failure(errorMessage: 'Something went wrong'),
      ],
    );
  });

  group('getTransactions', () {
    final transactions = [
      WalletEntity(
        id: '1',
        amount: 500,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    blocTest<WalletCubit, WalletState>(
      'emits [loading, success] when transactions are fetched successfully',
      build: () {
        when(
          mockGetTransactionsUseCase.call(),
        ).thenAnswer((_) async => Right(transactions));
        return walletCubit;
      },
      act: (cubit) => cubit.getTransactions(),
      expect: () => [
        WalletState.loading(),
        WalletState.success(transactions: transactions),
      ],
    );

    blocTest<WalletCubit, WalletState>(
      'emits [loading, failure] when fetching transactions fails',
      build: () {
        when(mockGetTransactionsUseCase.call()).thenAnswer(
          (_) async => Left(UnknownFailure(message: 'Fetch error')),
        );
        return walletCubit;
      },
      act: (cubit) => cubit.getTransactions(),
      expect: () => [
        WalletState.loading(),
        WalletState.failure(errorMessage: 'Fetch error'),
      ],
    );
  });

  group('AuthState custom getters', () {
    test('init state should not be loading, successful, or failed', () {
      final state = WalletState.init();

      expect(state.status, ProcessStatus.none);
      expect(state.isLoading, isFalse);
      expect(state.isSuccessful, isFalse);
      expect(state.isFailed, isFalse);
    });

    test('loading state should set isLoading = true', () {
      final state = WalletState.loading();

      expect(state.status, ProcessStatus.inProgress);
      expect(state.isLoading, isTrue);
      expect(state.isSuccessful, isFalse);
      expect(state.isFailed, isFalse);
    });

    test('success state should set isSuccessful = true', () {
      final state = WalletState.success(message: 'success');

      expect(state.status, ProcessStatus.successful);
      expect(state.message, 'success');
      expect(state.isLoading, isFalse);
      expect(state.isSuccessful, isTrue);
      expect(state.isFailed, isFalse);
    });

    test('failure state should set isFailed = true', () {
      final state = WalletState.failure(errorMessage: 'error');

      expect(state.status, ProcessStatus.failed);
      expect(state.message, 'error');
      expect(state.isLoading, isFalse);
      expect(state.isSuccessful, isFalse);
      expect(state.isFailed, isTrue);
    });
  });
}
