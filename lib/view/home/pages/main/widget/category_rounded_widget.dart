import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/design/sub_title_text.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../search/search_screen.dart';

class CategoryRoundedWidget extends StatelessWidget {
  final String img,name;
  const CategoryRoundedWidget({super.key, required this.img, required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(
          context,
          SearchScreen.routeName,
          arguments: name,
        );
      },
      child: Column(
        children: [
          AppImage(
            img,
            height: 50.h,
            width: 50.w,
            fit: BoxFit.contain,
          ),
          verticalSpace(15),
          SubTitleTextWidget(
              label: name,
            textStyle: TextStyles.textStyle18Normal.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
