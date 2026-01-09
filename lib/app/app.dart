import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../features/kana_game/application/kana_game_controller.dart';
import '../features/kana_game/data/kana_repository.dart';
import '../features/kana_game/ui/kana_guess_page.dart';
import '../features/kana_game/ui/kana_select_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Hirakata',
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: CupertinoColors.activeBlue,
      ),
      home: Builder(
        builder: (context) {
          return KanaSelectPage(
            onStart: (pool) {
              Navigator.of(context).push(
                CupertinoPageRoute<void>(
                  builder: (context) => KanaGuessPage(
                    controller: KanaGameController(
                      repository: KanaRepository(characters: pool),
                      random: Random(),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
