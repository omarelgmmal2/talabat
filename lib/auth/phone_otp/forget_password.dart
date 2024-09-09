import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabat_user/core/design/app_button.dart';
import 'package:talabat_user/core/design/app_input.dart';
import 'package:talabat_user/core/logic/helper_methods.dart';
import 'package:talabat_user/core/utils/spacing.dart';
import '../../core/design/app_image.dart';
import '../../core/regex/app_regex.dart';
import 'verfiy.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({
    super.key,
  });

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final phoneFocusNode = FocusNode();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 20.h,
          ),
          children: [
            Text(
              textAlign: TextAlign.center,
              "Forgot Password",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            verticalSpace(30),
            AppImage(
              "assets/images/lock.png",
              height: 132.h,
              width: 132.w,
            ),
            verticalSpace(10),
            Text(
              textAlign: TextAlign.center,
              "Enter the Email Address \nto reset your password",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            verticalSpace(12),
            Text(
              textAlign: TextAlign.center,
              "We will send you a code to reset \nyour password",
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xff58595B),
              ),
            ),
            verticalSpace(30),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phone",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  verticalSpace(13),
                  AppInput(
                    hintText: "Phone",
                    enableBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    textStyle: const TextStyle(color: Colors.grey),
                    textInputAction: TextInputAction.done,
                    focusNode: phoneFocusNode,
                    iconData: IconlyBold.call,
                    controller: phoneController,
                    type: TextInputType.phone,
                    fillColor: Colors.blue,
                    paddingBottom: 30,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !AppRegex.isPhoneNumberValid(value)) {
                        return "رقم الهاتف مطلوب";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            AppButton(
              text: "Send",
              buttonStyle: FilledButton.styleFrom(
                fixedSize: Size(double.infinity.w, 50.h),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              onPress: () async {
                if (formKey.currentState!.validate()) {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: "+20${phoneController.text}",
                    timeout: const Duration(seconds: 60),
                    verificationCompleted:
                        (PhoneAuthCredential credential) async {
                      await auth.signInWithCredential(credential);
                    },
                    verificationFailed: (FirebaseAuthException e) {
                      if (e.code == 'invalid-phone-number') {
                        debugPrint('The provided phone number is not valid.');
                      }
                    },
                    codeSent: (String verificationId, int? resendToken) async {
                      String smsCode = "xxxx";
                      navigateTo(
                        const MyVerify(),
                      );
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
