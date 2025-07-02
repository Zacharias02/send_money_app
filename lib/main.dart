import 'package:flutter/material.dart';
import 'package:send_money_app/application/app.dart';
import 'package:send_money_app/core/di/injector.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  runApp(const MyApp());
}
