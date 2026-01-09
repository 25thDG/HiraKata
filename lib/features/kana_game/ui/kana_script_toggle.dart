import 'package:flutter/cupertino.dart';

enum KanaScriptMode { hiragana, katakana, both }

class KanaScriptToggle extends StatelessWidget {
  const KanaScriptToggle({
    super.key,
    required this.mode,
    required this.onChanged,
    this.fontFamily,
    this.fontFamilyFallback,
  });

  final KanaScriptMode mode;
  final ValueChanged<KanaScriptMode> onChanged;
  final String? fontFamily;
  final List<String>? fontFamilyFallback;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.4,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );

    return CupertinoSlidingSegmentedControl<KanaScriptMode>(
      groupValue: mode,
      backgroundColor: CupertinoColors.systemGrey5,
      thumbColor: CupertinoColors.white,
      padding: const EdgeInsets.all(3),
      children: {
        KanaScriptMode.hiragana: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Text('Hiragana', style: textStyle),
        ),
        KanaScriptMode.katakana: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Text('Katakana', style: textStyle),
        ),
        KanaScriptMode.both: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Text('Both', style: textStyle),
        ),
      },
      onValueChanged: (value) {
        if (value == null) return;
        onChanged(value);
      },
    );
  }
}
