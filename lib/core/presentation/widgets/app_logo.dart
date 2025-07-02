import 'package:flutter/material.dart';
import 'package:send_money_app/application/generated/assets.gen.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = 180,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: ValueKey('App Logo'),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: size,
          maxHeight: 180,
        ),
        child: Assets.images.appLogo.image(height: size),
      ),
    );
  }
}
