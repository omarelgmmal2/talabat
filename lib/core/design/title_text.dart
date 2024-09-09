import 'package:flutter/material.dart';

class TitleTextWidget extends StatelessWidget {
  final String label;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final int? maxLines;

  const TitleTextWidget({
    super.key,
    required this.label,
    this.textStyle,
    this.textAlign,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
      label,
      style: textStyle,
    );
  }
}
