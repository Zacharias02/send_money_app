import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:send_money_app/core/common/failure.dart';
import 'package:send_money_app/features/authentication/domain/use_cases/sign_out_use_case.dart';

import '../../../../mocks/core_mock.mocks.dart';

void main() {
  late MockAuthLocalRepository mockRepository;
  late SignOutUseCase useCase;

  setUp(() {
    mockRepository = MockAuthLocalRepository();
    useCase = SignOutUseCase(mockRepository);
  });

  test('should return Right(null) when signOut is successful', () async {
    when(mockRepository.signOut()).thenAnswer((_) async => Right(null));

    final result = await useCase();

    expect(result, Right(null));
    verify(mockRepository.signOut()).called(1);
  });

  test('should return Left(Failure) when signOut fails', () async {
    final failure = UnknownFailure(message: 'Sign out failed');

    when(mockRepository.signOut()).thenAnswer((_) async => Left(failure));

    final result = await useCase();

    expect(result, Left(failure));
    verify(mockRepository.signOut()).called(1);
  });
}
