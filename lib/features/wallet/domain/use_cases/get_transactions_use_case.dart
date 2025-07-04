import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:send_money_app/core/common/failure.dart';
import 'package:send_money_app/features/wallet/domain/entities/wallet_entity/wallet_entity.dart';
import 'package:send_money_app/features/wallet/domain/repositories/wallet_remote_respository.dart';

@lazySingleton
class GetTransactionsUseCase {
  GetTransactionsUseCase(this._repository);

  final WalletRemoteRepository _repository;

  Future<Either<Failure, List<WalletEntity>>> call() =>
      _repository.getTransactions();
}
