import 'package:flutter/cupertino.dart';

import '../domain/models/kana_character.dart';

class KanaRowTile extends StatelessWidget {
  const KanaRowTile({
    super.key,
    required this.rowLabel,
    required this.characters,
    required this.selected,
    required this.onTap,
    required this.accentColor,
    required this.textColor,
    required this.mutedTextColor,
    this.fontFamily,
    this.fontFamilyFallback,
  });

  final String rowLabel;
  final List<KanaCharacter> characters;
  final bool selected;
  final VoidCallback onTap;
  final Color accentColor;
  final Color textColor;
  final Color mutedTextColor;
  final String? fontFamily;
  final List<String>? fontFamilyFallback;

  @override
  Widget build(BuildContext context) {
    final slots = _slotCharacters(characters);
    final labelStyle = TextStyle(
      color: selected ? accentColor : mutedTextColor,
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.8,
      fontFamily: fontFamily,
      fontFamilyFallback: fontFamilyFallback,
    );

    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      pressedOpacity: 0.6,
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 48,
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                style: labelStyle,
                child: Text(rowLabel),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: List.generate(
                      slots.length,
                      (index) {
                        final cell = slots[index];
                        return Expanded(
                          child: _KanaCell(
                            symbol: cell?.symbol,
                            romaji: cell?.romaji,
                            textColor: textColor,
                            mutedTextColor: mutedTextColor,
                            fontFamily: fontFamily,
                            fontFamilyFallback: fontFamilyFallback,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              opacity: selected ? 1.0 : 0.0,
              child: Icon(
                CupertinoIcons.check_mark,
                size: 18,
                color: accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<_KanaCellData?> _slotCharacters(List<KanaCharacter> characters) {
    final slots = List<_KanaCellData?>.filled(5, null);
    final indices = switch (characters.length) {
      5 => const [0, 1, 2, 3, 4],
      3 => const [0, 2, 4],
      2 => const [0, 4],
      1 => const [4],
      _ => List<int>.generate(
          characters.length > 5 ? 5 : characters.length,
          (index) => index,
        ),
    };

    for (var i = 0; i < indices.length; i++) {
      final character = characters[i];
      slots[indices[i]] = _KanaCellData(
        symbol: character.symbol,
        romaji: character.romaji,
      );
    }

    return slots;
  }
}

class _KanaCell extends StatelessWidget {
  const _KanaCell({
    required this.symbol,
    required this.romaji,
    required this.textColor,
    required this.mutedTextColor,
    this.fontFamily,
    this.fontFamilyFallback,
  });

  final String? symbol;
  final String? romaji;
  final Color textColor;
  final Color mutedTextColor;
  final String? fontFamily;
  final List<String>? fontFamilyFallback;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          symbol ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 22,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
            fontFamily: fontFamily,
            fontFamilyFallback: fontFamilyFallback,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          romaji ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: mutedTextColor,
            fontSize: 11,
            letterSpacing: 0.2,
            fontFamily: fontFamily,
            fontFamilyFallback: fontFamilyFallback,
          ),
        ),
      ],
    );
  }
}

class _KanaCellData {
  const _KanaCellData({required this.symbol, required this.romaji});

  final String symbol;
  final String romaji;
}
