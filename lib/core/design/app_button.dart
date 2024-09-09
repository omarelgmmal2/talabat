import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final ButtonStyle? buttonStyle;
  final VoidCallback onPress;

  const AppButton({
    super.key,
    required this.text,
    required this.onPress,
    this.textStyle,
    this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: buttonStyle,
      onPressed: onPress,
      child: Text(
        textAlign: TextAlign.center,
        text,
        style: textStyle,
      ),
    );
  }
}
