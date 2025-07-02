import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:send_money_app/core/common/failure.dart';
import 'package:send_money_app/features/authentication/domain/params/auth_params.dart';
import 'package:send_money_app/features/authentication/domain/use_cases/sign_in_use_case.dart';

import '../../../../mocks/core_mock.mocks.dart';

void main() {
  late MockAuthLocalRepository mockRepository;
  late SignInUseCase useCase;

  setUp(() {
    mockRepository = MockAuthLocalRepository();
    useCase = SignInUseCase(mockRepository);
  });

  const testParams = AuthParams(
    email: 'test@example.com',
    password: 'password123',
  );

  test('should return Right(null) when signIn is successful', () async {
    when(
      mockRepository.signIn(testParams),
    ).thenAnswer((_) async => Right(null));

    final result = await useCase(testParams);

    expect(result, Right(null));
    verify(mockRepository.signIn(testParams)).called(1);
  });

  test('should return Left(Failure) when signIn fails', () async {
    final failure = UnknownFailure(message: 'Unknown error');

    when(
      mockRepository.signIn(testParams),
    ).thenAnswer((_) async => Left(failure));

    final result = await useCase(testParams);

    expect(result, Left(failure));
    verify(mockRepository.signIn(testParams)).called(1);
  });
}
