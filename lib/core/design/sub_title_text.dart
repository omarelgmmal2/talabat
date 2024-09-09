import 'package:flutter/material.dart';

class SubTitleTextWidget extends StatelessWidget {
  final String label;
  final TextStyle? textStyle;
  final TextAlign? textAlign;

  const SubTitleTextWidget({
    super.key,
    required this.label,
    this.textStyle,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      label,
      style: textStyle,
    );
  }
}
