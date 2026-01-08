import 'kana_character.dart';

class KanaRow {
  const KanaRow({
    required this.id,
    required this.displayName,
    required this.hiragana,
    required this.katakana,
  });

  final String id;
  final String displayName;
  final List<KanaCharacter> hiragana;
  final List<KanaCharacter> katakana;

  List<KanaCharacter> charactersForScripts(Set<KanaScript> scripts) {
    final characters = <KanaCharacter>[];
    if (scripts.contains(KanaScript.hiragana)) {
      characters.addAll(hiragana);
    }
    if (scripts.contains(KanaScript.katakana)) {
      characters.addAll(katakana);
    }
    return List.unmodifiable(characters);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is KanaRow && runtimeType == other.runtimeType && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
