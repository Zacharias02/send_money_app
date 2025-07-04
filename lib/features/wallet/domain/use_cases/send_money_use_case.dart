import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:send_money_app/core/common/failure.dart';
import 'package:send_money_app/features/wallet/domain/repositories/wallet_remote_respository.dart';

@lazySingleton
class SendMoneyUseCase {
  SendMoneyUseCase(this._repository);

  final WalletRemoteRepository _repository;

  Future<Either<Failure, String>> call(double amount) {
    return _repository.sendMoney(amount: amount);
  }
}
