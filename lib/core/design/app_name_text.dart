import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'title_text.dart';

class AppNameText extends StatelessWidget {
  final TextStyle? style;
  final String text;

  const AppNameText({
    super.key,
    this.style,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      //period: const Duration(seconds: 6),
      baseColor: Colors.purple,
      highlightColor: Colors.red,
      child: TitleTextWidget(
        label: text,
        textStyle: style,
      ),
    );
  }
}
