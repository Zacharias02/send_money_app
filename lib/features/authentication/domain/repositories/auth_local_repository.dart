import 'package:dartz/dartz.dart';
import 'package:send_money_app/core/common/failure.dart';
import 'package:send_money_app/features/authentication/domain/params/auth_params.dart';

abstract class AuthLocalRepository {
  Future<Either<Failure, void>> signIn(AuthParams params);

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, bool>> isSessionActive();
}
