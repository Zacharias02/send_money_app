import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:send_money_app/core/common/app_constants.dart';
import 'package:send_money_app/core/common/exceptions.dart';
import 'package:send_money_app/core/common/failure.dart';
import 'package:send_money_app/features/wallet/data/data_sources/wallet_remote_data_source.dart';
import 'package:send_money_app/features/wallet/data/models/wallet_response_model/wallet_response_model.dart';
import 'package:send_money_app/features/wallet/domain/entities/wallet_entity/wallet_entity.dart';
import 'package:send_money_app/features/wallet/domain/repositories/wallet_remote_respository.dart';

@Injectable(as: WalletRemoteRepository)
@LazySingleton()
class WalletRemoteRepositoryImpl implements WalletRemoteRepository {
  WalletRemoteRepositoryImpl(this._remoteDataSource);

  final WalletRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, String>> sendMoney({
    required double amount,
  }) async {
    try {
      await _remoteDataSource.sendMoney(amount: amount);
      return Right(AppConstants.kSendMoneySuccess);
    } on HttpException catch (se) {
      return Left(
        ServerFailure(
          status: se.status,
          message: se.message,
          statusCode: se.statusCode,
        ),
      );
    } catch (e) {
      return Left(UnknownFailure(message: AppConstants.kUnknownError));
    }
  }

  @override
  Future<Either<Failure, List<WalletEntity>>> getTransactions() async {
    try {
      final response = await _remoteDataSource.getTransactions();
      final data = response.map((e) => e.toEntity()).toList();
      return Right(data);
    } on HttpException catch (se) {
      return Left(
        ServerFailure(
          status: se.status,
          message: se.message,
          statusCode: se.statusCode,
        ),
      );
    } catch (e) {
      return Left(UnknownFailure(message: AppConstants.kUnknownError));
    }
  }
}
