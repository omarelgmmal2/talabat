import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/design/sub_title_text.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/text_styles.dart';

class MyAppMethods {
  static Future<void> showErrorORWarningDialog({
    required BuildContext context,
    required String subtitle,
    required Function function,
    bool isError = true,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0.r),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppImage(
                  AssetsData.warning,
                  height: 60.h,
                  width: 60.w,
                ),
                verticalSpace(16),
                SubTitleTextWidget(
                  label: subtitle,
                  textStyle: TextStyles.textStyle18Normal.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
               verticalSpace(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: !isError,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: SubTitleTextWidget(
                            label: "Cancel",
                          textStyle: TextStyles.textStyle18Normal.copyWith(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    horizontalSpace(20),
                    TextButton(
                      onPressed: () {
                        function();
                        Navigator.pop(context);
                      },
                      child: SubTitleTextWidget(
                          label: "OK",
                        textStyle: TextStyles.textStyle18Normal.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
    );
  }
}
