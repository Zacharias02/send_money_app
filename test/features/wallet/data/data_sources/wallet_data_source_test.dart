import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money_app/core/common/exceptions.dart';
import 'package:send_money_app/features/wallet/data/data_sources/wallet_remote_data_source.dart';
import 'package:send_money_app/features/wallet/data/models/wallet_response_model/wallet_response_model.dart';

import '../../../../mocks/core_mock.mocks.dart';

void main() {
  late WalletRemoteDataSource dataSource;
  late MockWalletApiService mockApi;

  setUp(() {
    mockApi = MockWalletApiService();
    dataSource = WalletRemoteDataSourceImpl(mockApi);
  });

  group('sendMoney', () {
    test('should call WalletApiService.sendMoney and complete', () async {
      when(
        mockApi.sendMoney(amount: 1000.0),
      ).thenAnswer((_) async => Future.value());

      await dataSource.sendMoney(amount: 1000.0);

      verify(mockApi.sendMoney(amount: 1000.0)).called(1);
    });

    test('should throw HttpException on DioException', () async {
      when(mockApi.sendMoney(amount: 1000.0)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/money'),
          response: Response(
            requestOptions: RequestOptions(path: '/money'),
            statusCode: 400,
            statusMessage: 'Bad Request',
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      expect(
        () => dataSource.sendMoney(amount: 1000.0),
        throwsA(isA<HttpException>()),
      );
    });
  });

  group('getTransactions', () {
    test('should return list of WalletResponseModel', () async {
      final responseList = [
        WalletResponseModel(
          id: 'txn1',
          amount: 500.0,
          createdAt: DateTime.parse('2024-01-01'),
          updatedAt: DateTime.parse('2024-01-01'),
        ),
        WalletResponseModel(
          id: 'txn2',
          amount: 750.0,
          createdAt: DateTime.parse('2024-01-02'),
          updatedAt: DateTime.parse('2024-01-02'),
        ),
      ];

      when(mockApi.getTransactions()).thenAnswer((_) async => responseList);

      final result = await dataSource.getTransactions();

      expect(result, responseList);
      verify(mockApi.getTransactions()).called(1);
    });

    test('should throw HttpException on DioException', () async {
      when(mockApi.getTransactions()).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/money'),
          response: Response(
            requestOptions: RequestOptions(path: '/money'),
            statusCode: 500,
            statusMessage: 'Server Error',
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      expect(
        () => dataSource.getTransactions(),
        throwsA(isA<HttpException>()),
      );
    });
  });
}
