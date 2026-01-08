import '../domain/models/kana_character.dart';
import '../domain/models/kana_row.dart';

class KanaRowDataset {
  const KanaRowDataset._();

  static const List<KanaRow> rows = [
    KanaRow(
      id: 'a',
      displayName: 'A Row',
      hiragana: [
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'あ',
          romaji: 'a',
          audioKey: 'hira_a',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'い',
          romaji: 'i',
          audioKey: 'hira_i',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'う',
          romaji: 'u',
          audioKey: 'hira_u',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'え',
          romaji: 'e',
          audioKey: 'hira_e',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'お',
          romaji: 'o',
          audioKey: 'hira_o',
        ),
      ],
      katakana: [
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ア',
          romaji: 'a',
          audioKey: 'kata_a',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'イ',
          romaji: 'i',
          audioKey: 'kata_i',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ウ',
          romaji: 'u',
          audioKey: 'kata_u',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'エ',
          romaji: 'e',
          audioKey: 'kata_e',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'オ',
          romaji: 'o',
          audioKey: 'kata_o',
        ),
      ],
    ),
    KanaRow(
      id: 'ka',
      displayName: 'Ka Row',
      hiragana: [
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'か',
          romaji: 'ka',
          audioKey: 'hira_ka',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'き',
          romaji: 'ki',
          audioKey: 'hira_ki',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'く',
          romaji: 'ku',
          audioKey: 'hira_ku',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'け',
          romaji: 'ke',
          audioKey: 'hira_ke',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'こ',
          romaji: 'ko',
          audioKey: 'hira_ko',
        ),
      ],
      katakana: [
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'カ',
          romaji: 'ka',
          audioKey: 'kata_ka',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'キ',
          romaji: 'ki',
          audioKey: 'kata_ki',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ク',
          romaji: 'ku',
          audioKey: 'kata_ku',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ケ',
          romaji: 'ke',
          audioKey: 'kata_ke',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'コ',
          romaji: 'ko',
          audioKey: 'kata_ko',
        ),
      ],
    ),
    KanaRow(
      id: 'sa',
      displayName: 'Sa Row',
      hiragana: [
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'さ',
          romaji: 'sa',
          audioKey: 'hira_sa',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'し',
          romaji: 'shi',
          audioKey: 'hira_shi',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'す',
          romaji: 'su',
          audioKey: 'hira_su',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'せ',
          romaji: 'se',
          audioKey: 'hira_se',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'そ',
          romaji: 'so',
          audioKey: 'hira_so',
        ),
      ],
      katakana: [
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'サ',
          romaji: 'sa',
          audioKey: 'kata_sa',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'シ',
          romaji: 'shi',
          audioKey: 'kata_shi',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ス',
          romaji: 'su',
          audioKey: 'kata_su',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'セ',
          romaji: 'se',
          audioKey: 'kata_se',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ソ',
          romaji: 'so',
          audioKey: 'kata_so',
        ),
      ],
    ),
    KanaRow(
      id: 'ta',
      displayName: 'Ta Row',
      hiragana: [
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'た',
          romaji: 'ta',
          audioKey: 'hira_ta',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'ち',
          romaji: 'chi',
          audioKey: 'hira_chi',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'つ',
          romaji: 'tsu',
          audioKey: 'hira_tsu',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'て',
          romaji: 'te',
          audioKey: 'hira_te',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'と',
          romaji: 'to',
          audioKey: 'hira_to',
        ),
      ],
      katakana: [
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'タ',
          romaji: 'ta',
          audioKey: 'kata_ta',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'チ',
          romaji: 'chi',
          audioKey: 'kata_chi',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ツ',
          romaji: 'tsu',
          audioKey: 'kata_tsu',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'テ',
          romaji: 'te',
          audioKey: 'kata_te',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ト',
          romaji: 'to',
          audioKey: 'kata_to',
        ),
      ],
    ),
    KanaRow(
      id: 'na',
      displayName: 'Na Row',
      hiragana: [
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'な',
          romaji: 'na',
          audioKey: 'hira_na',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'に',
          romaji: 'ni',
          audioKey: 'hira_ni',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'ぬ',
          romaji: 'nu',
          audioKey: 'hira_nu',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'ね',
          romaji: 'ne',
          audioKey: 'hira_ne',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'の',
          romaji: 'no',
          audioKey: 'hira_no',
        ),
      ],
      katakana: [
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ナ',
          romaji: 'na',
          audioKey: 'kata_na',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ニ',
          romaji: 'ni',
          audioKey: 'kata_ni',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ヌ',
          romaji: 'nu',
          audioKey: 'kata_nu',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ネ',
          romaji: 'ne',
          audioKey: 'kata_ne',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ノ',
          romaji: 'no',
          audioKey: 'kata_no',
        ),
      ],
    ),
    KanaRow(
      id: 'ha',
      displayName: 'Ha Row',
      hiragana: [
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'は',
          romaji: 'ha',
          audioKey: 'hira_ha',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'ひ',
          romaji: 'hi',
          audioKey: 'hira_hi',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'ふ',
          romaji: 'fu',
          audioKey: 'hira_fu',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'へ',
          romaji: 'he',
          audioKey: 'hira_he',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'ほ',
          romaji: 'ho',
          audioKey: 'hira_ho',
        ),
      ],
      katakana: [
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ハ',
          romaji: 'ha',
          audioKey: 'kata_ha',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ヒ',
          romaji: 'hi',
          audioKey: 'kata_hi',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'フ',
          romaji: 'fu',
          audioKey: 'kata_fu',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ヘ',
          romaji: 'he',
          audioKey: 'kata_he',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ホ',
          romaji: 'ho',
          audioKey: 'kata_ho',
        ),
      ],
    ),
    KanaRow(
      id: 'ma',
      displayName: 'Ma Row',
      hiragana: [
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'ま',
          romaji: 'ma',
          audioKey: 'hira_ma',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'み',
          romaji: 'mi',
          audioKey: 'hira_mi',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'む',
          romaji: 'mu',
          audioKey: 'hira_mu',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'め',
          romaji: 'me',
          audioKey: 'hira_me',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'も',
          romaji: 'mo',
          audioKey: 'hira_mo',
        ),
      ],
      katakana: [
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'マ',
          romaji: 'ma',
          audioKey: 'kata_ma',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ミ',
          romaji: 'mi',
          audioKey: 'kata_mi',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ム',
          romaji: 'mu',
          audioKey: 'kata_mu',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'メ',
          romaji: 'me',
          audioKey: 'kata_me',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'モ',
          romaji: 'mo',
          audioKey: 'kata_mo',
        ),
      ],
    ),
    KanaRow(
      id: 'ya',
      displayName: 'Ya Row',
      hiragana: [
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'や',
          romaji: 'ya',
          audioKey: 'hira_ya',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'ゆ',
          romaji: 'yu',
          audioKey: 'hira_yu',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'よ',
          romaji: 'yo',
          audioKey: 'hira_yo',
        ),
      ],
      katakana: [
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ヤ',
          romaji: 'ya',
          audioKey: 'kata_ya',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ユ',
          romaji: 'yu',
          audioKey: 'kata_yu',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ヨ',
          romaji: 'yo',
          audioKey: 'kata_yo',
        ),
      ],
    ),
    KanaRow(
      id: 'ra',
      displayName: 'Ra Row',
      hiragana: [
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'ら',
          romaji: 'ra',
          audioKey: 'hira_ra',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'り',
          romaji: 'ri',
          audioKey: 'hira_ri',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'る',
          romaji: 'ru',
          audioKey: 'hira_ru',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'れ',
          romaji: 're',
          audioKey: 'hira_re',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'ろ',
          romaji: 'ro',
          audioKey: 'hira_ro',
        ),
      ],
      katakana: [
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ラ',
          romaji: 'ra',
          audioKey: 'kata_ra',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'リ',
          romaji: 'ri',
          audioKey: 'kata_ri',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ル',
          romaji: 'ru',
          audioKey: 'kata_ru',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'レ',
          romaji: 're',
          audioKey: 'kata_re',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ロ',
          romaji: 'ro',
          audioKey: 'kata_ro',
        ),
      ],
    ),
    KanaRow(
      id: 'wa',
      displayName: 'Wa Row',
      hiragana: [
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'わ',
          romaji: 'wa',
          audioKey: 'hira_wa',
        ),
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'を',
          romaji: 'wo',
          audioKey: 'hira_wo',
        ),
      ],
      katakana: [
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ワ',
          romaji: 'wa',
          audioKey: 'kata_wa',
        ),
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ヲ',
          romaji: 'wo',
          audioKey: 'kata_wo',
        ),
      ],
    ),
    KanaRow(
      id: 'n',
      displayName: 'N Row',
      hiragana: [
        KanaCharacter(
          script: KanaScript.hiragana,
          symbol: 'ん',
          romaji: 'n',
          audioKey: 'hira_n',
        ),
      ],
      katakana: [
        KanaCharacter(
          script: KanaScript.katakana,
          symbol: 'ン',
          romaji: 'n',
          audioKey: 'kata_n',
        ),
      ],
    ),
  ];

  static List<KanaRow> all() => List.unmodifiable(rows);

  static KanaRow? byId(String id) {
    for (final row in rows) {
      if (row.id == id) return row;
    }
    return null;
  }
}
