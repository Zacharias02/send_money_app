import 'package:flutter/material.dart';
import 'package:send_money_app/core/common/app_theme.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({
    super.key,
    this.size,
  });

  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(
          AppTheme.kTealAccentColor,
        ),
        backgroundColor: Colors.grey.shade700,
      ),
    );
  }
}
