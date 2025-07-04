import 'package:dartz/dartz.dart';
import 'package:send_money_app/core/common/failure.dart';
import 'package:send_money_app/features/wallet/domain/entities/wallet_entity/wallet_entity.dart';

abstract class WalletRemoteRepository {
  Future<Either<Failure, String>> sendMoney({required double amount});

  Future<Either<Failure, List<WalletEntity>>> getTransactions();
}
