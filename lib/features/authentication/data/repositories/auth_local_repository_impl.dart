import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:send_money_app/core/common/app_constants.dart';
import 'package:send_money_app/core/common/exceptions.dart';
import 'package:send_money_app/core/common/failure.dart';
import 'package:send_money_app/features/authentication/data/data_sources/auth_local_data_source.dart';
import 'package:send_money_app/features/authentication/domain/params/auth_params.dart';
import 'package:send_money_app/features/authentication/domain/repositories/auth_local_repository.dart';

@Injectable(as: AuthLocalRepository)
@lazySingleton
class AuthLocalRepositoryImpl implements AuthLocalRepository {
  const AuthLocalRepositoryImpl(this._dataSource);

  final AuthLocalDataSource _dataSource;

  @override
  Future<Either<Failure, void>> signIn(AuthParams params) async {
    try {
      await Future.delayed(Duration(seconds: 1));

      if (params.email != AppConstants.kTmpEmail &&
          params.password != AppConstants.kTmpPassword) {
        return Left(NoDataFoundFailure(message: AppConstants.kNoAccountFound));
      }

      await _dataSource.saveAuthSession(isAuthenticated: true);
      return Right(null);
    } on LocalStorageException catch (lse) {
      return Left(LocalStorageFailure(message: lse.message));
    } catch (e) {
      return Left(UnknownFailure(message: AppConstants.kUnknownError));
    }
  }

  @override
  Future<Either<Failure, bool>> isSessionActive() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      final isAuthenticated = await _dataSource.getAuthSession();
      return Right(isAuthenticated);
    } on LocalStorageException catch (lse) {
      return Left(LocalStorageFailure(message: lse.message));
    } catch (e) {
      return Left(UnknownFailure(message: AppConstants.kUnknownError));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      await _dataSource.deleteAuthSession();
      return Right(null);
    } on LocalStorageException catch (lse) {
      return Left(LocalStorageFailure(message: lse.message));
    } catch (e) {
      return Left(UnknownFailure(message: AppConstants.kUnknownError));
    }
  }
}
