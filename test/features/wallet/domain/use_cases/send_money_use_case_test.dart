import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:send_money_app/core/common/failure.dart';
import 'package:send_money_app/features/wallet/domain/use_cases/send_money_use_case.dart';

import '../../../../mocks/core_mock.mocks.dart';

void main() {
  late SendMoneyUseCase useCase;
  late MockWalletRemoteRepository mockRepository;

  setUp(() {
    mockRepository = MockWalletRemoteRepository();
    useCase = SendMoneyUseCase(mockRepository);
  });

  test('should return success string when sendMoney is successful', () async {
    // arrange
    const amount = 100.0;
    const successMessage = 'Money sent successfully';

    when(
      mockRepository.sendMoney(amount: amount),
    ).thenAnswer((_) async => const Right(successMessage));

    // act
    final result = await useCase(amount);

    // assert
    expect(result, const Right(successMessage));
    verify(mockRepository.sendMoney(amount: amount)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Failure when sendMoney throws', () async {
    // arrange
    const amount = 100.0;
    final failure = UnknownFailure(message: 'Something went wrong');

    when(
      mockRepository.sendMoney(amount: amount),
    ).thenAnswer((_) async => Left(failure));

    // act
    final result = await useCase(amount);

    // assert
    expect(result, Left(failure));
    verify(mockRepository.sendMoney(amount: amount)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
