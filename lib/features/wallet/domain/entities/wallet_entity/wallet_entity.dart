import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:send_money_app/features/wallet/data/models/wallet_response_model/wallet_response_model.dart';

part 'wallet_entity.freezed.dart';

@freezed
abstract class WalletEntity with _$WalletEntity {
  factory WalletEntity({
    String? id,
    double? amount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _WalletEntity;
}

extension WalletEntityToModel on WalletEntity {
  WalletResponseModel toModel() {
    return WalletResponseModel(
      id: id,
      amount: amount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  // String get formattedCreatedAt =>
  //     (createdAt != null) ? StringUtils.getFormattedDate(createdAt) : 'N/A';

  // String get formattedUpdatedAt =>
  //     (updatedAt != null) ? StringUtils.getFormattedDate(updatedAt) : 'N/A';
}
