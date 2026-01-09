import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class KanaGuessInput extends StatelessWidget {
  const KanaGuessInput({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onSubmit,
    required this.accentColor,
    required this.backgroundColor,
    required this.textColor,
    required this.hintColor,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onSubmit;
  final Color accentColor;
  final Color backgroundColor;
  final Color textColor;
  final Color hintColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.16),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: CupertinoTextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: true,
        autocorrect: false,
        enableSuggestions: false,
        textCapitalization: TextCapitalization.none,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.text,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontSize: 20,
          letterSpacing: 1.1,
          fontWeight: FontWeight.w500,
        ),
        cursorColor: accentColor,
        inputFormatters: const [LowercaseTextFormatter()],
        placeholder: 'romaji',
        placeholderStyle: TextStyle(
          color: hintColor,
          fontSize: 18,
          letterSpacing: 0.8,
        ),
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        onSubmitted: onSubmit,
      ),
    );
  }
}

class LowercaseTextFormatter extends TextInputFormatter {
  const LowercaseTextFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final lowered = newValue.text.toLowerCase();
    return newValue.copyWith(text: lowered, selection: newValue.selection);
  }
}
