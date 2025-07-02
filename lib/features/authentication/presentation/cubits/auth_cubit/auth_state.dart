part of 'auth_cubit.dart';

@freezed
abstract class AuthState with _$AuthState {
  const AuthState._();

  factory AuthState({
    String? errorMessage,
    @Default(false) bool isAuthenticated,
    @Default(ProcessStatus.none) ProcessStatus status,
  }) = _AuthState;

  factory AuthState.init() => AuthState();

  factory AuthState.loading() => AuthState(status: ProcessStatus.inProgress);

  factory AuthState.success({required bool isAuthenticated}) => AuthState(
    isAuthenticated: isAuthenticated,
    status: ProcessStatus.successful,
  );

  factory AuthState.failure([String? errorMessage]) => AuthState(
    errorMessage: errorMessage,
    status: ProcessStatus.failed,
  );

  // Custom getters
  bool get isLoading => status == ProcessStatus.inProgress;
  bool get isSuccessful => status == ProcessStatus.successful;
  bool get isFailed => status == ProcessStatus.failed;
}
