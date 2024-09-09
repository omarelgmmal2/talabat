import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/design/app_image.dart';
import '../../core/design/app_input.dart';
import '../../core/design/app_name_text.dart';
import '../../core/design/title_text.dart';
import '../../core/regex/app_regex.dart';
import '../../core/utils/assets.dart';
import '../../core/utils/spacing.dart';
import '../../core/utils/text_styles.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            AppNameText(text: "ShopSmart", style: TextStyles.textStyle20Bold),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(IconlyLight.arrowLeft),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          AppImage(
            AssetsData.forgotPassword,
            height: 300.h,
            width: 300.w,
          ),
          //verticalSpace(10),
          TitleTextWidget(
            label: "Forgot password",
            textStyle: TextStyles.textStyle20Bold,
          ),
          verticalSpace(5),
          TitleTextWidget(
            label:
                "Please enter the email address you'd like your\npassword reset information sent to",
            textStyle: TextStyles.textStyle18Normal.copyWith(
              fontSize: 15.sp,
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                AppInput(
                  hintText: "Email address",
                  textStyle: const TextStyle(color: Colors.grey),
                  textInputAction: TextInputAction.next,
                  paddingTop: 35,
                  focusNode: emailFocusNode,
                  onChanged: (value) {},
                  onFieldSubmitted: (value) {},
                  iconData: IconlyLight.message,
                  controller: emailController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !AppRegex.isEmailValid(value)) {
                      return "بريدك الالكتروني غير صحيح";
                    }
                    return null;
                  },
                  type: TextInputType.emailAddress,
                  enableBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(20),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              fixedSize: Size(double.infinity.w, 50.h),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                //navigateTo(const HomeView());
              }
              FocusScope.of(context).unfocus();
            },
            icon: const Icon(IconlyBold.send, color: Colors.white),
            label: Text(
              "Request link",
              style: TextStyles.textStyle18Normal.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
