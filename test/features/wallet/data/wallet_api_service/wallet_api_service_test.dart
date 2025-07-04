import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:send_money_app/core/common/exceptions.dart';
import 'package:send_money_app/features/wallet/data/models/wallet_response_model/wallet_response_model.dart';
import 'package:send_money_app/features/wallet/data/wallet_api_service/wallet_api_service.dart';

import '../../../../mocks/core_mock.mocks.dart';

void main() {
  late MockDio mockDio;
  late WalletApiService apiService;

  setUp(() {
    mockDio = MockDio();
    apiService = WalletApiService(mockDio);
  });

  group('sendMoney', () {
    test('should complete successfully when API returns 200', () async {
      when(
        mockDio.post(
          any,
          data: anyNamed('data'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/money'),
          statusCode: 200,
          data: null,
        ),
      );

      expect(() => apiService.sendMoney(amount: 500.0), returnsNormally);
    });

    test('should throw HttpException on DioException', () async {
      when(
        mockDio.post(
          any,
          data: anyNamed('data'),
        ),
      ).thenThrow(
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
        () => apiService.sendMoney(amount: 500.0),
        throwsA(isA<HttpException>()),
      );
    });
  });

  group('getTransactions', () {
    test('should return list of WalletResponseModel on success', () async {
      final mockJsonData = [
        {
          '_id': '1',
          'amount': 500,
          'createdAt': '2024-01-01',
          'updatedAt': '2024-01-01',
        },
        {
          '_id': '2',
          'amount': 300,
          'createdAt': '2024-01-02',
          'updatedAt': '2024-01-02',
        },
      ];

      when(mockDio.get(any)).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/money'),
          data: mockJsonData,
          statusCode: 200,
        ),
      );

      final result = await apiService.getTransactions();

      expect(result, isA<List<WalletResponseModel>>());
      expect(result.length, 2);
      expect(result[0].amount, 500);
      verify(mockDio.get('/money')).called(1);
    });

    test('should throw HttpException on DioException', () async {
      when(mockDio.get(any)).thenThrow(
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
        () => apiService.getTransactions(),
        throwsA(isA<HttpException>()),
      );
    });
  });
}
