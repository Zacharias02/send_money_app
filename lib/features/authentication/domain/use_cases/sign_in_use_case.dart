import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:send_money_app/core/common/failure.dart';
import 'package:send_money_app/features/authentication/domain/params/auth_params.dart';
import 'package:send_money_app/features/authentication/domain/repositories/auth_local_repository.dart';

@lazySingleton
class SignInUseCase {
  const SignInUseCase(this._authLocalRepository);

  final AuthLocalRepository _authLocalRepository;

  Future<Either<Failure, void>> call(AuthParams params) =>
      _authLocalRepository.signIn(params);
}
