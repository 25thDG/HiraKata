import 'package:flutter/cupertino.dart';

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
  late final Map<String, KanaRow> _rowById;

  @override
  void initState() {
    super.initState();
    _rows = List<KanaRow>.unmodifiable(widget.rows ?? KanaRowDataset.all());
    _rowById = {for (final row in _rows) row.id: row};
    _controller = widget.controller ??
        KanaRowSelectionController(
          rows: _rows,
        );
  }

  void _setScriptMode(KanaScriptMode mode) {
    setState(() {
      switch (mode) {
        case KanaScriptMode.hiragana:
          _controller.setScripts(hiraganaEnabled: true, katakanaEnabled: false);
        case KanaScriptMode.katakana:
          _controller.setScripts(hiraganaEnabled: false, katakanaEnabled: true);
        case KanaScriptMode.both:
          _controller.setScripts(hiraganaEnabled: true, katakanaEnabled: true);
      }
    });
  }

  void _toggleRow(KanaRow row) {
    setState(() {
      _controller.toggleRow(row.id);
    });
  }

  void _selectAllRows() {
    setState(() {
      _controller.setSelectedRows(_rows.map((row) => row.id));
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
      CupertinoPageRoute<void>(
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
    final selectedRowIds = state.selectedRowIds;
    final allSelected =
        selectedRowIds.length == _rows.length && _rows.isNotEmpty;
    final mode = _scriptModeFromState(state.hiraganaEnabled, state.katakanaEnabled);
    final showHiragana = mode != KanaScriptMode.katakana;
    final canStart = _controller.isSelectionValid;

    return CupertinoPageScaffold(
      backgroundColor: palette.background,
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: const Text('Kana'),
                trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  pressedOpacity: 0.6,
                  onPressed: allSelected ? null : _selectAllRows,
                  child: Text(
                    'Check All',
                    style: baseTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: allSelected
                          ? palette.textSecondary
                          : palette.accent,
                    ),
                  ),
                ),
                backgroundColor: palette.background,
                border: null,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choose the rows you want to practice.',
                        style: baseTextStyle.copyWith(
                          fontSize: 14,
                          letterSpacing: 0.2,
                          color: palette.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      KanaScriptToggle(
                        mode: mode,
                        onChanged: _setScriptMode,
                        fontFamily: baseTextStyle.fontFamily,
                        fontFamilyFallback: baseTextStyle.fontFamilyFallback,
                      ),
                      if (mode == KanaScriptMode.both)
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            'Includes Hiragana and Katakana.',
                            style: baseTextStyle.copyWith(
                              fontSize: 12,
                              letterSpacing: 0.2,
                              color: palette.textSecondary,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 140),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    _buildSections(
                      selectedRowIds: selectedRowIds,
                      showHiragana: showHiragana,
                      palette: palette,
                      baseTextStyle: baseTextStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              minimum: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: IgnorePointer(
                ignoring: !canStart,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  opacity: canStart ? 1.0 : 0.4,
                  child: CupertinoButton(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    borderRadius: BorderRadius.circular(14),
                    color: palette.accent,
                    pressedOpacity: 0.85,
                    onPressed: _start,
                    child: Text(
                      'Start Practice',
                      style: baseTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                        color: palette.buttonText,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSections({
    required Set<String> selectedRowIds,
    required bool showHiragana,
    required _KanaSelectPalette palette,
    required TextStyle baseTextStyle,
  }) {
    final widgets = <Widget>[];

    for (final group in _rowGroups) {
      final rows = group.rowIds
          .map((id) => _rowById[id])
          .whereType<KanaRow>()
          .toList(growable: false);
      if (rows.isEmpty) continue;

      widgets.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(6, 6, 6, 8),
          child: Text(
            group.title,
            style: baseTextStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.9,
              color: palette.textSecondary,
            ),
          ),
        ),
      );

      for (final row in rows) {
        widgets.add(
          KanaRowTile(
            rowLabel: _rowLabel(row.displayName),
            characters: showHiragana ? row.hiragana : row.katakana,
            selected: selectedRowIds.contains(row.id),
            onTap: () => _toggleRow(row),
            accentColor: palette.accent,
            textColor: palette.textPrimary,
            mutedTextColor: palette.textSecondary,
            fontFamily: baseTextStyle.fontFamily,
            fontFamilyFallback: baseTextStyle.fontFamilyFallback,
          ),
        );
        widgets.add(const SizedBox(height: 8));
      }
    }

    return widgets;
  }

  KanaScriptMode _scriptModeFromState(bool hiraganaEnabled, bool katakanaEnabled) {
    if (hiraganaEnabled && katakanaEnabled) return KanaScriptMode.both;
    if (hiraganaEnabled) return KanaScriptMode.hiragana;
    return KanaScriptMode.katakana;
  }

  String _rowLabel(String displayName) {
    return displayName.replaceAll(' Row', '').trim();
  }

  List<_RowGroup> get _rowGroups => const [
        _RowGroup(
          title: 'Basics',
          rowIds: [
            'a',
            'ka',
            'sa',
            'ta',
            'na',
            'ha',
            'ma',
            'ya',
            'ra',
            'wa',
            'n',
          ],
        ),
        _RowGroup(
          title: 'Dakuten',
          rowIds: ['ga', 'za', 'da', 'ba'],
        ),
        _RowGroup(
          title: 'Handakuten',
          rowIds: ['pa'],
        ),
        _RowGroup(
          title: 'Yoon',
          rowIds: [
            'kya',
            'gya',
            'sha',
            'ja',
            'cha',
            'nya',
            'hya',
            'bya',
            'pya',
            'mya',
            'rya',
          ],
        ),
      ];
}

class _RowGroup {
  const _RowGroup({required this.title, required this.rowIds});

  final String title;
  final List<String> rowIds;
}

class _KanaSelectPalette {
  const _KanaSelectPalette({
    required this.background,
    required this.textPrimary,
    required this.textSecondary,
    required this.accent,
    required this.buttonText,
  });

  final Color background;
  final Color textPrimary;
  final Color textSecondary;
  final Color accent;
  final Color buttonText;

  factory _KanaSelectPalette.light() {
    return const _KanaSelectPalette(
      background: CupertinoColors.systemGroupedBackground,
      textPrimary: CupertinoColors.label,
      textSecondary: CupertinoColors.secondaryLabel,
      accent: CupertinoColors.activeBlue,
      buttonText: CupertinoColors.white,
    );
  }
}
