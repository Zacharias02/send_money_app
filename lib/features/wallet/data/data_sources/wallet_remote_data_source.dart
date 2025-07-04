import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:send_money_app/core/common/exceptions.dart';
import 'package:send_money_app/features/wallet/data/models/wallet_response_model/wallet_response_model.dart';
import 'package:send_money_app/features/wallet/data/wallet_api_service/wallet_api_service.dart';

abstract class WalletRemoteDataSource {
  Future<void> sendMoney({required double amount});

  Future<List<WalletResponseModel>> getTransactions();
}

@Injectable(as: WalletRemoteDataSource)
@lazySingleton
class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  WalletRemoteDataSourceImpl(this._api);

  final WalletApiService _api;

  @override
  Future<void> sendMoney({required double amount}) async {
    try {
      await _api.sendMoney(amount: amount);
    } on DioException catch (e) {
      throw HttpException(
        statusCode: e.response?.statusCode,
        status: e.response?.statusMessage,
        message: e.message,
      );
    }
  }

  @override
  Future<List<WalletResponseModel>> getTransactions() async {
    try {
      return await _api.getTransactions();
    } on DioException catch (e) {
      throw HttpException(
        statusCode: e.response?.statusCode,
        status: e.response?.statusMessage,
        message: e.message,
      );
    }
  }
}
