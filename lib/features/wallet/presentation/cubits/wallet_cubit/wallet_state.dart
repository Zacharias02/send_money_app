part of 'wallet_cubit.dart';

@freezed
abstract class WalletState with _$WalletState {
  const WalletState._();

  factory WalletState({
    String? message,
    List<WalletEntity>? transactions,
    @Default(ProcessStatus.none) ProcessStatus status,
  }) = _WalletState;

  factory WalletState.init() => WalletState();

  factory WalletState.loading() =>
      WalletState(status: ProcessStatus.inProgress);

  factory WalletState.success({
    String? message,
    List<WalletEntity>? transactions,
  }) => WalletState(
    message: message,
    transactions: transactions,
    status: ProcessStatus.successful,
  );

  factory WalletState.failure({
    required String errorMessage,
  }) => WalletState(
    message: errorMessage,
    status: ProcessStatus.failed,
  );

  // Custom getters
  bool get isLoading => status == ProcessStatus.inProgress;
  bool get isSuccessful => status == ProcessStatus.successful;
  bool get isFailed => status == ProcessStatus.failed;
}
