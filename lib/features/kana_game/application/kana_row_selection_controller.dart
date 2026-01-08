import '../data/kana_row_dataset.dart';
import '../domain/models/kana_character.dart';
import '../domain/models/kana_row.dart';
import '../domain/models/kana_row_selection_state.dart';

class KanaRowSelectionController {
  KanaRowSelectionController({
    List<KanaRow>? rows,
    Set<String>? initialSelectedRowIds,
    bool hiraganaEnabled = true,
    bool katakanaEnabled = true,
  }) {
    final resolvedRows = List<KanaRow>.unmodifiable(rows ?? KanaRowDataset.all());
    _rows = resolvedRows;
    _rowById = {for (final row in _rows) row.id: row};
    _state = KanaRowSelectionState(
      selectedRowIds:
          initialSelectedRowIds ?? _rows.map((row) => row.id).toSet(),
      hiraganaEnabled: hiraganaEnabled,
      katakanaEnabled: katakanaEnabled,
    );
  }

  late final List<KanaRow> _rows;
  late final Map<String, KanaRow> _rowById;
  late KanaRowSelectionState _state;

  KanaRowSelectionState get state => _state;

  List<KanaRow> get selectedRows => List.unmodifiable(
        _rows.where((row) => _state.selectedRowIds.contains(row.id)),
      );

  Set<KanaScript> get enabledScripts => _state.enabledScripts;

  List<KanaCharacter> get finalKanaPool {
    if (!_state.isValid) {
      return const [];
    }

    final pool = <KanaCharacter>[];
    for (final row in selectedRows) {
      if (_state.hiraganaEnabled) {
        pool.addAll(row.hiragana);
      }
      if (_state.katakanaEnabled) {
        pool.addAll(row.katakana);
      }
    }
    return List.unmodifiable(pool);
  }

  bool get isSelectionValid => _state.isValid;

  void toggleRow(String rowId) {
    if (!_rowById.containsKey(rowId)) return;
    final updated = _state.selectedRowIds.toSet();
    if (updated.contains(rowId)) {
      updated.remove(rowId);
    } else {
      updated.add(rowId);
    }
    _state = _state.copyWith(selectedRowIds: updated);
  }

  void setRowSelected(String rowId, bool selected) {
    if (!_rowById.containsKey(rowId)) return;
    final updated = _state.selectedRowIds.toSet();
    if (selected) {
      updated.add(rowId);
    } else {
      updated.remove(rowId);
    }
    _state = _state.copyWith(selectedRowIds: updated);
  }

  void setSelectedRows(Iterable<String> rowIds) {
    final updated = rowIds.where(_rowById.containsKey).toSet();
    _state = _state.copyWith(selectedRowIds: updated);
  }

  void setHiraganaEnabled(bool enabled) {
    _state = _state.copyWith(hiraganaEnabled: enabled);
  }

  void setKatakanaEnabled(bool enabled) {
    _state = _state.copyWith(katakanaEnabled: enabled);
  }

  void setScripts({bool? hiraganaEnabled, bool? katakanaEnabled}) {
    _state = _state.copyWith(
      hiraganaEnabled: hiraganaEnabled,
      katakanaEnabled: katakanaEnabled,
    );
  }

  void resetToDefaults() {
    _state = KanaRowSelectionState(
      selectedRowIds: _rows.map((row) => row.id).toSet(),
      hiraganaEnabled: true,
      katakanaEnabled: true,
    );
  }
}
