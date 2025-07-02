import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:send_money_app/core/common/failure.dart';
import 'package:send_money_app/features/authentication/domain/repositories/auth_local_repository.dart';

@lazySingleton
class SignOutUseCase {
  const SignOutUseCase(this._authLocalRepository);

  final AuthLocalRepository _authLocalRepository;

  Future<Either<Failure, void>> call() => _authLocalRepository.signOut();
}
