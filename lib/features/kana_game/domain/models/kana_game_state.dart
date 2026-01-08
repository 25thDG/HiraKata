import 'kana_character.dart';

class KanaGameState {
  const KanaGameState({
    required this.currentCharacter,
    required this.correctCount,
    required this.incorrectCount,
    required this.totalGuesses,
  });

  final KanaCharacter currentCharacter;
  final int correctCount;
  final int incorrectCount;
  final int totalGuesses;

  factory KanaGameState.initial(KanaCharacter character) {
    return KanaGameState(
      currentCharacter: character,
      correctCount: 0,
      incorrectCount: 0,
      totalGuesses: 0,
    );
  }

  KanaGameState copyWith({
    KanaCharacter? currentCharacter,
    int? correctCount,
    int? incorrectCount,
    int? totalGuesses,
  }) {
    return KanaGameState(
      currentCharacter: currentCharacter ?? this.currentCharacter,
      correctCount: correctCount ?? this.correctCount,
      incorrectCount: incorrectCount ?? this.incorrectCount,
      totalGuesses: totalGuesses ?? this.totalGuesses,
    );
  }
}
