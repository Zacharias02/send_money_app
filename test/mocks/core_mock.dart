import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:send_money_app/core/services/local_storage_service.dart';
import 'package:send_money_app/features/authentication/data/data_sources/auth_local_data_source.dart';
import 'package:send_money_app/features/authentication/domain/repositories/auth_local_repository.dart';
import 'package:send_money_app/features/authentication/domain/use_cases/check_session_use_case.dart';
import 'package:send_money_app/features/authentication/domain/use_cases/sign_in_use_case.dart';
import 'package:send_money_app/features/authentication/domain/use_cases/sign_out_use_case.dart';
import 'package:send_money_app/features/authentication/presentation/cubits/auth_cubit/auth_cubit.dart';

@GenerateMocks([
  FlutterSecureStorage,
  LocalStorageService,
  AuthLocalDataSource,
  AuthLocalRepository,
  SignInUseCase,
  SignOutUseCase,
  CheckSessionUseCase,
  AuthCubit,
])
void main() {}
