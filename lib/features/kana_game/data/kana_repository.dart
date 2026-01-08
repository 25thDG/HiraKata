import 'dart:math';

import '../domain/models/kana_character.dart';
import 'kana_dataset.dart';

class KanaRepository {
  KanaRepository({Iterable<KanaCharacter>? characters})
      : _characters = List.unmodifiable(
          characters ?? KanaDataset.all(),
        );

  final List<KanaCharacter> _characters;

  List<KanaCharacter> all() => _characters;

  KanaCharacter randomCharacter(Random random) {
    if (_characters.isEmpty) {
      throw StateError('No kana characters available.');
    }

    return _characters[random.nextInt(_characters.length)];
  }
}
