import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:send_money_app/core/di/injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: false,
  asExtension: false,
)
void configureDependencies() => $initGetIt(getIt);
