import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/design/sub_title_text.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.function,
  });

  final String imagePath, text;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        function();
      },
      leading: AppImage(
        imagePath,
        height: 30.h,
      ),
      title: SubTitleTextWidget(label: text),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}
