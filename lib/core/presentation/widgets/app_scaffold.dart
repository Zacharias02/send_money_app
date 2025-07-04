import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: AppTheme.kWhiteColor,
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: body,
      ),
    );
  }
}
