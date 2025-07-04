import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:send_money_app/core/common/enums/process_status.dart';
import 'package:send_money_app/features/wallet/domain/entities/wallet_entity/wallet_entity.dart';
import 'package:send_money_app/features/wallet/domain/use_cases/get_transactions_use_case.dart';
import 'package:send_money_app/features/wallet/domain/use_cases/send_money_use_case.dart';

part 'wallet_state.dart';
part 'wallet_cubit.freezed.dart';

@lazySingleton
class WalletCubit extends Cubit<WalletState> {
  WalletCubit(
    this._sendMoneyUseCase,
    this._getTransactionsUseCase,
  ) : super(WalletState.init());

  final SendMoneyUseCase _sendMoneyUseCase;
  final GetTransactionsUseCase _getTransactionsUseCase;

  Future<void> sendMoney(String amount) async {
    emit(WalletState.loading());

    final either = await _sendMoneyUseCase.call(double.parse(amount));

    either.fold(
      (left) => emit(WalletState.failure(errorMessage: left.message!)),
      (message) => emit(WalletState.success(message: message)),
    );
  }

  Future<void> getTransactions() async {
    emit(WalletState.loading());

    final either = await _getTransactionsUseCase.call();

    either.fold(
      (left) => emit(WalletState.failure(errorMessage: left.message!)),
      (transactions) => emit(WalletState.success(transactions: transactions)),
    );
  }
}
