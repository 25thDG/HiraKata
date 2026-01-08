import 'dart:math';

import 'package:flutter/material.dart';

import '../application/kana_game_controller.dart';
import '../data/kana_repository.dart';
import '../domain/models/kana_game_state.dart';
import 'kana_character_display.dart';
import 'kana_guess_input.dart';
import 'kana_guess_stats.dart';

class KanaGuessPage extends StatefulWidget {
  const KanaGuessPage({super.key, KanaGameController? controller})
      : _controller = controller;

  final KanaGameController? _controller;

  @override
  State<KanaGuessPage> createState() => _KanaGuessPageState();
}

class _KanaGuessPageState extends State<KanaGuessPage> {
  static const Duration _animDuration = Duration(milliseconds: 200);
  static const Duration _feedbackHold = Duration(milliseconds: 220);

  late final KanaGameController _controller;
  late final bool _ownsController;
  late KanaGameState _state;
  late final TextEditingController _textController;
  late final FocusNode _focusNode;
  late final void Function() _removeListener;
  bool _hasState = false;

  _FeedbackStatus _feedbackStatus = _FeedbackStatus.neutral;
  double _characterScale = 1.0;
  Offset _characterOffset = Offset.zero;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _ownsController = widget._controller == null;
    _controller = widget._controller ??
        KanaGameController(
          repository: KanaRepository(),
          random: Random(),
        );
    _textController = TextEditingController();
    _focusNode = FocusNode();
    _removeListener = _controller.addListener((state) {
      _state = state;
      if (!_hasState) {
        _hasState = true;
        return;
      }
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _removeListener();
    if (_ownsController) {
      _controller.dispose();
    }
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _submitGuess(String value) async {
    final guess = value.trim();
    if (guess.isEmpty || _isProcessing) return;
    _isProcessing = true;

    final isCorrect = _controller.submitGuess(guess);
    _triggerFeedback(isCorrect);
    _textController.clear();

    await Future.delayed(_feedbackHold);
    if (!mounted) return;
    _controller.nextCharacter();
    _resetFeedback();
    _focusNode.requestFocus();
    _isProcessing = false;
  }

  void _triggerFeedback(bool isCorrect) {
    setState(() {
      _feedbackStatus =
          isCorrect ? _FeedbackStatus.correct : _FeedbackStatus.incorrect;
      _characterScale = isCorrect ? 1.03 : 1.0;
      _characterOffset = isCorrect ? Offset.zero : const Offset(0.02, 0);
    });

    if (isCorrect) {
      Future.delayed(const Duration(milliseconds: 120), () {
        if (!mounted) return;
        setState(() => _characterScale = 1.0);
      });
    } else {
      Future.delayed(const Duration(milliseconds: 120), () {
        if (!mounted) return;
        setState(() => _characterOffset = Offset.zero);
      });
    }
  }

  void _resetFeedback() {
    setState(() {
      _feedbackStatus = _FeedbackStatus.neutral;
      _characterScale = 1.0;
      _characterOffset = Offset.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = _KanaGuessPalette.dark();
    final size = MediaQuery.sizeOf(context);
    final characterSize = min(size.width * 0.45, 210.0).clamp(120.0, 220.0);

    final accentColor = switch (_feedbackStatus) {
      _FeedbackStatus.correct => palette.correct,
      _FeedbackStatus.incorrect => palette.incorrect,
      _FeedbackStatus.neutral => palette.accent,
    };

    return Theme(
      data: Theme.of(context).copyWith(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: palette.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Expanded(
                  child: Center(
                    child: AnimatedContainer(
                      duration: _animDuration,
                      curve: Curves.easeOut,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        color: palette.surface.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: accentColor.withOpacity(
                              _feedbackStatus == _FeedbackStatus.neutral
                                  ? 0.1
                                  : 0.2,
                            ),
                            blurRadius: 36,
                            offset: const Offset(0, 18),
                          ),
                        ],
                      ),
                      child: AnimatedSlide(
                        duration: _animDuration,
                        curve: Curves.easeOut,
                        offset: _characterOffset,
                        child: AnimatedScale(
                          duration: _animDuration,
                          curve: Curves.easeOut,
                          scale: _characterScale,
                          child: KanaCharacterDisplay(
                            symbol: _state.currentCharacter.symbol,
                            fontSize: characterSize,
                            textColor: palette.textPrimary,
                            glowColor: accentColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Type the romaji',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: palette.textSecondary,
                    fontSize: 14,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 14),
                KanaGuessInput(
                  controller: _textController,
                  focusNode: _focusNode,
                  onSubmit: (value) => _submitGuess(value),
                  accentColor: accentColor,
                  backgroundColor: palette.surface,
                  textColor: palette.textPrimary,
                  hintColor: palette.textMuted,
                ),
                const SizedBox(height: 24),
                KanaGuessStats(
                  correct: _state.correctCount,
                  incorrect: _state.incorrectCount,
                  total: _state.totalGuesses,
                  textColor: palette.textSecondary,
                  valueColor: palette.textPrimary,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum _FeedbackStatus { neutral, correct, incorrect }

class _KanaGuessPalette {
  const _KanaGuessPalette({
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.accent,
    required this.correct,
    required this.incorrect,
  });

  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color accent;
  final Color correct;
  final Color incorrect;

  factory _KanaGuessPalette.dark() {
    return const _KanaGuessPalette(
      background: Color(0xFF0D0D0B),
      surface: Color(0xFF1A1A16),
      textPrimary: Color(0xFFF5F1E8),
      textSecondary: Color(0xFFC9C3B8),
      textMuted: Color(0xFF9B9488),
      accent: Color(0xFFAADAC4),
      correct: Color(0xFF9BD3AE),
      incorrect: Color(0xFFE3A4A4),
    );
  }
}
