enum KanaScript {
  hiragana,
  katakana,
}

class KanaCharacter {
  const KanaCharacter({
    required this.script,
    required this.symbol,
    required this.romaji,
    this.audioKey,
  });

  final KanaScript script;
  final String symbol;
  final String romaji;
  final String? audioKey;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is KanaCharacter &&
            runtimeType == other.runtimeType &&
            script == other.script &&
            symbol == other.symbol &&
            romaji == other.romaji &&
            audioKey == other.audioKey;
  }

  @override
  int get hashCode => Object.hash(script, symbol, romaji, audioKey);
}
