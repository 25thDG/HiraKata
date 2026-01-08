import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

import 'package:hirakata/features/kana_game/application/kana_game_controller.dart';
import 'package:hirakata/features/kana_game/data/kana_dataset.dart';
import 'package:hirakata/features/kana_game/data/kana_repository.dart';
import 'package:hirakata/features/kana_game/domain/models/kana_character.dart';

class SequenceRandom implements Random {
  SequenceRandom(this._values);

  final List<int> _values;
  int _index = 0;

  @override
  int nextInt(int max) {
    final value = _values[_index % _values.length];
    _index += 1;
    return value % max;
  }

  @override
  double nextDouble() => 0.0;

  @override
  bool nextBool() => false;
}

void main() {
  test('kana dataset includes core entries and yoon entries', () {
    expect(KanaDataset.hiragana.length, greaterThanOrEqualTo(46));
    expect(KanaDataset.katakana.length, greaterThanOrEqualTo(46));
    expect(
      KanaDataset.hiragana,
      contains(
        const KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'あ',
          romaji: 'a',
          audioKey: 'hira_a',
        ),
      ),
    );
    expect(
      KanaDataset.katakana,
      contains(
        const KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'キャ',
          romaji: 'kya',
          audioKey: 'kata_kya',
        ),
      ),
    );
  });

  test('repository returns random character and throws when empty', () {
    final repository = KanaRepository(
      characters: const [
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'あ',
          romaji: 'a',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ア',
          romaji: 'a',
        ),
      ],
    );

    final random = SequenceRandom([1]);
    expect(repository.randomCharacter(random).symbol, 'ア');

    final emptyRepository = KanaRepository(characters: const []);
    expect(
      () => emptyRepository.randomCharacter(random),
      throwsA(isA<StateError>()),
    );
  });

  test('controller updates stats, advances, and resets', () {
    final repository = KanaRepository(
      characters: const [
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'あ',
          romaji: 'a',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'か',
          romaji: 'ka',
        ),
      ],
    );

    final container = ProviderContainer(
      overrides: [
        kanaRepositoryProvider.overrideWithValue(repository),
        randomProvider.overrideWithValue(SequenceRandom([0, 1, 0])),
      ],
    );
    addTearDown(container.dispose);

    final controller = container.read(kanaGameControllerProvider.notifier);
    final initialState = container.read(kanaGameControllerProvider);

    expect(initialState.currentCharacter.symbol, 'あ');
    expect(initialState.totalGuesses, 0);

    final correct = controller.submitGuess('a');
    expect(correct, isTrue);

    final afterCorrect = container.read(kanaGameControllerProvider);
    expect(afterCorrect.correctCount, 1);
    expect(afterCorrect.incorrectCount, 0);
    expect(afterCorrect.totalGuesses, 1);

    controller.nextCharacter();
    final afterNext = container.read(kanaGameControllerProvider);
    expect(afterNext.currentCharacter.symbol, 'か');

    final incorrect = controller.submitGuess('a');
    expect(incorrect, isFalse);

    final afterIncorrect = container.read(kanaGameControllerProvider);
    expect(afterIncorrect.correctCount, 1);
    expect(afterIncorrect.incorrectCount, 1);
    expect(afterIncorrect.totalGuesses, 2);

    controller.reset();
    final resetState = container.read(kanaGameControllerProvider);
    expect(resetState.correctCount, 0);
    expect(resetState.incorrectCount, 0);
    expect(resetState.totalGuesses, 0);
    expect(resetState.currentCharacter.symbol, 'あ');
  });
}
