import 'dart:math';

import 'package:riverpod/riverpod.dart';

import '../data/kana_repository.dart';
import '../domain/models/kana_game_state.dart';

final kanaRepositoryProvider = Provider<KanaRepository>((ref) {
  return KanaRepository();
});

final randomProvider = Provider<Random>((ref) => Random());

final kanaGameControllerProvider =
    StateNotifierProvider<KanaGameController, KanaGameState>((ref) {
  final repository = ref.read(kanaRepositoryProvider);
  final random = ref.read(randomProvider);
  return KanaGameController(repository: repository, random: random);
});

class KanaGameController extends StateNotifier<KanaGameState> {
  KanaGameController({
    required KanaRepository repository,
    required Random random,
  })  : _repository = repository,
        _random = random,
        super(KanaGameState.initial(repository.randomCharacter(random)));

  final KanaRepository _repository;
  final Random _random;

  bool submitGuess(String guess) {
    final normalizedGuess = _normalizeGuess(guess);
    final isCorrect = normalizedGuess == state.currentCharacter.romaji;

    state = state.copyWith(
      correctCount: state.correctCount + (isCorrect ? 1 : 0),
      incorrectCount: state.incorrectCount + (isCorrect ? 0 : 1),
      totalGuesses: state.totalGuesses + 1,
    );

    return isCorrect;
  }

  void nextCharacter() {
    state = state.copyWith(
      currentCharacter: _repository.randomCharacter(_random),
    );
  }

  void reset() {
    state = KanaGameState.initial(
      _repository.randomCharacter(_random),
    );
  }

  String _normalizeGuess(String guess) => guess.trim().toLowerCase();
}
