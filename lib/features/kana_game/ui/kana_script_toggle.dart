import 'package:flutter/material.dart';

class KanaScriptToggle extends StatelessWidget {
  const KanaScriptToggle({
    super.key,
    required this.hiraganaEnabled,
    required this.katakanaEnabled,
    required this.onHiraganaTap,
    required this.onKatakanaTap,
    required this.accentColor,
    required this.surfaceColor,
    required this.textColor,
    required this.mutedTextColor,
    this.fontFamily,
    this.fontFamilyFallback,
  });

  final bool hiraganaEnabled;
  final bool katakanaEnabled;
  final VoidCallback onHiraganaTap;
  final VoidCallback onKatakanaTap;
  final Color accentColor;
  final Color surfaceColor;
  final Color textColor;
  final Color mutedTextColor;
  final String? fontFamily;
  final List<String>? fontFamilyFallback;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ScriptPill(
            label: 'Hiragana',
            selected: hiraganaEnabled,
            onTap: onHiraganaTap,
            accentColor: accentColor,
            surfaceColor: surfaceColor,
            textColor: textColor,
            mutedTextColor: mutedTextColor,
            fontFamily: fontFamily,
            fontFamilyFallback: fontFamilyFallback,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ScriptPill(
            label: 'Katakana',
            selected: katakanaEnabled,
            onTap: onKatakanaTap,
            accentColor: accentColor,
            surfaceColor: surfaceColor,
            textColor: textColor,
            mutedTextColor: mutedTextColor,
            fontFamily: fontFamily,
            fontFamilyFallback: fontFamilyFallback,
          ),
        ),
      ],
    );
  }
}

class _ScriptPill extends StatelessWidget {
  const _ScriptPill({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.accentColor,
    required this.surfaceColor,
    required this.textColor,
    required this.mutedTextColor,
    this.fontFamily,
    this.fontFamilyFallback,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color accentColor;
  final Color surfaceColor;
  final Color textColor;
  final Color mutedTextColor;
  final String? fontFamily;
  final List<String>? fontFamilyFallback;

  @override
  Widget build(BuildContext context) {
    final background =
        selected ? accentColor.withOpacity(0.16) : surfaceColor;
    final labelColor = selected ? textColor : mutedTextColor;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(selected ? 0.16 : 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                  color: labelColor,
                  fontFamily: fontFamily,
                  fontFamilyFallback: fontFamilyFallback,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
