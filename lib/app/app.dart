import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../features/kana_game/ui/kana_guess_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.light(),
      home: const KanaGuessPage(),
    );
  }
}
