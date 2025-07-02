import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:send_money_app/core/common/failure.dart';
import 'package:send_money_app/features/authentication/domain/use_cases/check_session_use_case.dart';

import '../../../../mocks/core_mock.mocks.dart';

void main() {
  late MockAuthLocalRepository mockRepository;
  late CheckSessionUseCase useCase;

  setUp(() {
    mockRepository = MockAuthLocalRepository();
    useCase = CheckSessionUseCase(mockRepository);
  });

  test('should return Right(true) when session is active', () async {
    when(mockRepository.isSessionActive()).thenAnswer((_) async => Right(true));

    final result = await useCase();

    expect(result, Right(true));
    verify(mockRepository.isSessionActive()).called(1);
  });

  test('should return Right(false) when session is inactive', () async {
    when(
      mockRepository.isSessionActive(),
    ).thenAnswer((_) async => Right(false));

    final result = await useCase();

    expect(result, Right(false));
    verify(mockRepository.isSessionActive()).called(1);
  });

  test('should return Left(Failure) when session check fails', () async {
    final failure = UnknownFailure(message: 'Check failed');

    when(
      mockRepository.isSessionActive(),
    ).thenAnswer((_) async => Left(failure));

    final result = await useCase();

    expect(result, Left(failure));
    verify(mockRepository.isSessionActive()).called(1);
  });
}
