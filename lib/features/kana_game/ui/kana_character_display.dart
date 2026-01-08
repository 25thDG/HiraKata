import 'package:flutter/material.dart';

class KanaCharacterDisplay extends StatelessWidget {
  const KanaCharacterDisplay({
    super.key,
    required this.symbol,
    required this.fontSize,
    required this.textColor,
    required this.glowColor,
  });

  final String symbol;
  final double fontSize;
  final Color textColor;
  final Color glowColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (child, animation) {
        final scale = Tween<double>(begin: 0.98, end: 1.0).animate(animation);
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(scale: scale, child: child),
        );
      },
      child: Text(
        symbol,
        key: ValueKey(symbol),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.6,
          color: textColor,
          shadows: [
            Shadow(
              color: glowColor.withOpacity(0.28),
              blurRadius: 26,
              offset: const Offset(0, 8),
            ),
            Shadow(
              color: glowColor.withOpacity(0.16),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}
