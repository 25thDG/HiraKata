import 'package:flutter/material.dart';

import '../application/kana_row_selection_controller.dart';
import '../data/kana_row_dataset.dart';
import '../domain/models/kana_character.dart';
import '../domain/models/kana_row.dart';
import 'kana_guess_page.dart';
import 'kana_row_tile.dart';
import 'kana_script_toggle.dart';

class KanaSelectPage extends StatefulWidget {
  const KanaSelectPage({
    super.key,
    this.controller,
    this.rows,
    this.onStart,
  });

  final KanaRowSelectionController? controller;
  final List<KanaRow>? rows;
  final ValueChanged<List<KanaCharacter>>? onStart;

  @override
  State<KanaSelectPage> createState() => _KanaSelectPageState();
}

class _KanaSelectPageState extends State<KanaSelectPage> {
  late final KanaRowSelectionController _controller;
  late final List<KanaRow> _rows;

  @override
  void initState() {
    super.initState();
    _rows = List<KanaRow>.unmodifiable(widget.rows ?? KanaRowDataset.all());
    _controller = widget.controller ??
        KanaRowSelectionController(
          rows: _rows,
        );
  }

  void _toggleHiragana() {
    setState(() {
      _controller.setHiraganaEnabled(!_controller.state.hiraganaEnabled);
    });
  }

  void _toggleKatakana() {
    setState(() {
      _controller.setKatakanaEnabled(!_controller.state.katakanaEnabled);
    });
  }

  void _toggleRow(KanaRow row) {
    setState(() {
      _controller.toggleRow(row.id);
    });
  }

  void _start() {
    if (!_controller.isSelectionValid) return;
    final pool = _controller.finalKanaPool;
    if (widget.onStart != null) {
      widget.onStart!(pool);
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => const KanaGuessPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final palette = _KanaSelectPalette.light();
    final baseTextStyle = const TextStyle(
      fontFamily: 'Noto Sans JP',
      fontFamilyFallback: [
        'Hiragino Sans',
        'SF Pro Text',
        'Yu Gothic',
        'Arial Unicode MS',
      ],
    );
    final state = _controller.state;
    final showHiragana = state.hiraganaEnabled || !state.katakanaEnabled;
    final selectedRowIds = state.selectedRowIds;

    return Theme(
      data: Theme.of(context).copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: palette.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: palette.accent,
          brightness: Brightness.light,
        ),
      ),
      child: Scaffold(
        backgroundColor: palette.background,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(28, 24, 28, 12),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choose Kana',
                        style: baseTextStyle.copyWith(
                          fontSize: 30,
                          letterSpacing: 0.4,
                          fontWeight: FontWeight.w600,
                          color: palette.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Select rows to practice',
                        style: baseTextStyle.copyWith(
                          fontSize: 16,
                          letterSpacing: 0.6,
                          color: palette.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      KanaScriptToggle(
                        hiraganaEnabled: state.hiraganaEnabled,
                        katakanaEnabled: state.katakanaEnabled,
                        onHiraganaTap: _toggleHiragana,
                        onKatakanaTap: _toggleKatakana,
                        accentColor: palette.accent,
                        surfaceColor: palette.surface,
                        textColor: palette.textPrimary,
                        mutedTextColor: palette.textSecondary,
                        fontFamily: baseTextStyle.fontFamily,
                        fontFamilyFallback: baseTextStyle.fontFamilyFallback,
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final row = _rows[index];
                      final selected = selectedRowIds.contains(row.id);
                      final characters =
                          showHiragana ? row.hiragana : row.katakana;
                      final romajiLabels = row.hiragana
                          .map((character) => character.romaji)
                          .toList(growable: false);

                      return KanaRowTile(
                        rowName: row.displayName,
                        kanaSymbols:
                            characters.map((character) => character.symbol),
                        romajiLabels: romajiLabels,
                        selected: selected,
                        onTap: () => _toggleRow(row),
                        accentColor: palette.accent,
                        surfaceColor: palette.surface,
                        textColor: palette.textPrimary,
                        mutedTextColor: palette.textSecondary,
                        fontFamily: baseTextStyle.fontFamily,
                        fontFamilyFallback: baseTextStyle.fontFamilyFallback,
                      );
                    },
                    childCount: _rows.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18,
                    childAspectRatio: 1.02,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.fromLTRB(24, 12, 24, 20),
          child: SizedBox(
            width: double.infinity,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              opacity: _controller.isSelectionValid ? 1.0 : 0.55,
              child: FilledButton(
                onPressed: _controller.isSelectionValid ? _start : null,
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(vertical: 16),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith(
                    (states) {
                      if (states.contains(MaterialState.disabled)) {
                        return palette.surface;
                      }
                      return palette.accent;
                    },
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith(
                    (states) {
                      if (states.contains(MaterialState.disabled)) {
                        return palette.textSecondary;
                      }
                      return palette.buttonText;
                    },
                  ),
                  elevation: MaterialStateProperty.resolveWith(
                    (states) => states.contains(MaterialState.disabled) ? 0 : 2,
                  ),
                ),
                child: Text(
                  'Start Practice',
                  style: baseTextStyle.copyWith(
                    fontSize: 16,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _KanaSelectPalette {
  const _KanaSelectPalette({
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.accent,
    required this.buttonText,
  });

  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color accent;
  final Color buttonText;

  factory _KanaSelectPalette.light() {
    return const _KanaSelectPalette(
      background: Color(0xFFF7F4EF),
      surface: Color(0xFFF0ECE4),
      textPrimary: Color(0xFF1B1A16),
      textSecondary: Color(0xFF706A60),
      accent: Color(0xFF4FA98A),
      buttonText: Color(0xFF0F1B16),
    );
  }
}
