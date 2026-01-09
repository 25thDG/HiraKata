import 'package:flutter/cupertino.dart';

class KanaGuessStats extends StatelessWidget {
  const KanaGuessStats({
    super.key,
    required this.correct,
    required this.incorrect,
    required this.total,
    required this.textColor,
    required this.valueColor,
  });

  final int correct;
  final int incorrect;
  final int total;
  final Color textColor;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _StatItem(
          label: 'Correct',
          value: correct,
          textColor: textColor,
          valueColor: valueColor,
        ),
        _StatItem(
          label: 'Incorrect',
          value: incorrect,
          textColor: textColor,
          valueColor: valueColor,
        ),
        _StatItem(
          label: 'Total',
          value: total,
          textColor: textColor,
          valueColor: valueColor,
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.label,
    required this.value,
    required this.textColor,
    required this.valueColor,
  });

  final String label;
  final int value;
  final Color textColor;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value.toString(),
          style: TextStyle(
            color: valueColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}
