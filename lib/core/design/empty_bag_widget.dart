import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/spacing.dart';
import '../utils/text_styles.dart';
import 'app_button.dart';
import 'app_image.dart';
import 'sub_title_text.dart';
import 'title_text.dart';

class EmptyBagWidget extends StatelessWidget {
  final String img;
  final String title;
  final String? text;
  final String subTitle;
  final String buttonText;

  const EmptyBagWidget({
    super.key,
    required this.img,
    required this.title,
    required this.subTitle,
    required this.buttonText,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 70),
      children: [
        AppImage(
          img,
          height: 300.h,
          fit: BoxFit.scaleDown,
        ),
        verticalSpace(16),
        TitleTextWidget(
          textAlign: TextAlign.center,
          label: text ?? "",
          textStyle: TextStyles.textStyle20Bold.copyWith(
            fontSize: 35.sp,
            color: Colors.red,
          ),
        ),
        verticalSpace(16),
        TitleTextWidget(
          textAlign: TextAlign.center,
          label: title,
          textStyle: TextStyles.textStyle20Bold,
        ),
        verticalSpace(16),
        SubTitleTextWidget(
            textAlign: TextAlign.center,
            textStyle: TextStyles.textStyle20Bold.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
            label: subTitle),
        verticalSpace(45),
        Center(
          child: AppButton(
            buttonStyle: FilledButton.styleFrom(
              backgroundColor: Colors.blue,
              fixedSize: const Size(150, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            text: buttonText,
            textStyle: TextStyles.textStyle18Normal,
            onPress: () {},
          ),
        ),
      ],
    );
  }
}
