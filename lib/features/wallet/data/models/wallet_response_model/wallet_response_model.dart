import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:send_money_app/features/wallet/domain/entities/wallet_entity/wallet_entity.dart';

part 'wallet_response_model.freezed.dart';
part 'wallet_response_model.g.dart';

@freezed
abstract class WalletResponseModel with _$WalletResponseModel {
  factory WalletResponseModel({
    String? id,
    double? amount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _WalletResponseModel;

  factory WalletResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WalletResponseModelFromJson(json);
}

extension WalletResponseModelToEntity on WalletResponseModel {
  WalletEntity toEntity() {
    return WalletEntity(
      id: id,
      amount: amount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
