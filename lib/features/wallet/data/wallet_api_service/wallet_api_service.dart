import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:send_money_app/core/common/exceptions.dart';
import 'package:send_money_app/features/wallet/data/models/wallet_response_model/wallet_response_model.dart';

@lazySingleton
class WalletApiService {
  WalletApiService(this._dio);

  final Dio _dio;

  Future<void> sendMoney({required double amount}) async {
    try {
      await _dio.post(
        '/money',
        data: {
          'amount': amount,
          'createdAt': DateTime.now().toIso8601String(),
          'updatedAt': DateTime.now().toIso8601String(),
        },
      );
    } on DioException catch (e) {
      throw HttpException(
        statusCode: e.response?.statusCode,
        status: e.response?.statusMessage,
        message: e.message,
      );
    }
  }

  Future<List<WalletResponseModel>> getTransactions() async {
    try {
      final response = await _dio.get('/money');
      final data = response.data as List<dynamic>;

      final transactions = data
          .map((item) => WalletResponseModel.fromJson(item))
          .toList();

      return transactions;
    } on DioException catch (e) {
      throw HttpException(
        statusCode: e.response?.statusCode,
        status: e.response?.statusMessage,
        message: e.message,
      );
    }
  }
}
