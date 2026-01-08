import 'kana_character.dart';

class KanaRowSelectionState {
  KanaRowSelectionState({
    required Set<String> selectedRowIds,
    required this.hiraganaEnabled,
    required this.katakanaEnabled,
  }) : selectedRowIds = Set.unmodifiable(selectedRowIds);

  final Set<String> selectedRowIds;
  final bool hiraganaEnabled;
  final bool katakanaEnabled;

  bool get hasSelectedRows => selectedRowIds.isNotEmpty;
  bool get hasEnabledScripts => hiraganaEnabled || katakanaEnabled;
  bool get isValid => hasSelectedRows && hasEnabledScripts;

  Set<KanaScript> get enabledScripts {
    final scripts = <KanaScript>{};
    if (hiraganaEnabled) {
      scripts.add(KanaScript.hiragana);
    }
    if (katakanaEnabled) {
      scripts.add(KanaScript.katakana);
    }
    return Set.unmodifiable(scripts);
  }

  KanaRowSelectionState copyWith({
    Set<String>? selectedRowIds,
    bool? hiraganaEnabled,
    bool? katakanaEnabled,
  }) {
    return KanaRowSelectionState(
      selectedRowIds: selectedRowIds ?? this.selectedRowIds,
      hiraganaEnabled: hiraganaEnabled ?? this.hiraganaEnabled,
      katakanaEnabled: katakanaEnabled ?? this.katakanaEnabled,
    );
  }
}
