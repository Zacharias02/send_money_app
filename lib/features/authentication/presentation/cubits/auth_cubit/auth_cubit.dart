import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:send_money_app/core/common/enums/process_status.dart';
import 'package:send_money_app/features/authentication/domain/params/auth_params.dart';
import 'package:send_money_app/features/authentication/domain/use_cases/check_session_use_case.dart';
import 'package:send_money_app/features/authentication/domain/use_cases/sign_in_use_case.dart';
import 'package:send_money_app/features/authentication/domain/use_cases/sign_out_use_case.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._signInUseCase,
    this._checkSessionUseCase,
    this._signOutUseCase,
  ) : super(AuthState.init());

  final SignInUseCase _signInUseCase;
  final CheckSessionUseCase _checkSessionUseCase;
  final SignOutUseCase _signOutUseCase;

  Future<void> signIn(String email, String password) async {
    final authParams = AuthParams(email: email, password: password);

    emit(AuthState.loading());

    final either = await _signInUseCase.call(authParams);

    either.fold(
      (left) => emit(AuthState.failure(left.message)),
      (_) => emit(AuthState.success(isAuthenticated: true)),
    );
  }

  Future<void> checkSession() async {
    emit(AuthState.loading());

    final either = await _checkSessionUseCase.call();

    either.fold(
      (left) => emit(AuthState.failure(left.message)),
      (isAuthenticated) =>
          emit(AuthState.success(isAuthenticated: isAuthenticated)),
    );
  }

  Future<void> signOut() async {
    emit(AuthState.loading());

    final either = await _signOutUseCase.call();

    either.fold(
      (left) => emit(AuthState.failure(left.message)),
      (_) => emit(AuthState.success(isAuthenticated: false)),
    );
  }
}
