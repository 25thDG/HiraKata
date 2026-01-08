import 'package:flutter/material.dart';

class KanaRowTile extends StatelessWidget {
  const KanaRowTile({
    super.key,
    required this.rowName,
    required this.kanaSymbols,
    required this.romajiLabels,
    required this.selected,
    required this.onTap,
    required this.accentColor,
    required this.surfaceColor,
    required this.textColor,
    required this.mutedTextColor,
    this.fontFamily,
    this.fontFamilyFallback,
  });

  final String rowName;
  final Iterable<String> kanaSymbols;
  final Iterable<String> romajiLabels;
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
    final background = selected
        ? Color.alphaBlend(accentColor.withOpacity(0.16), surfaceColor)
        : surfaceColor;

    return AnimatedScale(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      scale: selected ? 1.0 : 0.98,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(selected ? 0.18 : 0.06),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rowName,
                    style: TextStyle(
                      color: mutedTextColor,
                      fontSize: 12,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w600,
                      fontFamily: fontFamily,
                      fontFamilyFallback: fontFamilyFallback,
                    ),
                  ),
                  const Spacer(),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: kanaSymbols
                        .map(
                          (symbol) => Text(
                            symbol,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                              fontFamily: fontFamily,
                              fontFamilyFallback: fontFamilyFallback,
                            ),
                          ),
                        )
                        .toList(growable: false),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    children: romajiLabels
                        .map(
                          (label) => Text(
                            label,
                            style: TextStyle(
                              color: mutedTextColor,
                              fontSize: 12,
                              letterSpacing: 0.6,
                              fontFamily: fontFamily,
                              fontFamilyFallback: fontFamilyFallback,
                            ),
                          ),
                        )
                        .toList(growable: false),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
