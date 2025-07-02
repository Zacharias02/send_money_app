import 'package:flutter/material.dart';
import 'package:send_money_app/core/common/app_theme.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.appBarTitle,
  });

  final String? appBarTitle;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kWhiteColor,
      appBar: appBarTitle != null
          ? AppBar(
              title: Text(
                appBarTitle!,
                style: TextStyle(
                  color: AppTheme.kWhiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: AppTheme.kUltraDarkColor,
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: body,
      ),
    );
  }
}
