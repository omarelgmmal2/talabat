import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:talabat_user/core/design/app_image.dart';
import 'package:talabat_user/core/logic/helper_methods.dart';
import 'package:talabat_user/core/utils/spacing.dart';
import 'package:talabat_user/view/home/home_screen.dart';
import 'phone.dart';

class MyVerify extends StatefulWidget {
  const MyVerify({super.key});

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  final codeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: TextStyle(
          fontSize: 20.sp,
          color: const Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(234, 239, 243, 1),
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: const Color.fromRGBO(114, 178, 238, 1),
      ),
      borderRadius: BorderRadius.circular(8.r),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var code = "";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25.w, right: 25.w),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppImage(
                "assets/images/splash img.png",
                width: 150.w,
                height: 150.h,
              ),
              verticalSpace(25),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold,),
              ),
              verticalSpace(10),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16.sp,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpace(30),
              Form(
                key: formKey,
                child: Pinput(
                  length: 6,
                  controller: codeController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "الكود مطلوب";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    code = value;
                  },
                  showCursor: true,
                  onCompleted: (pin) => debugPrint(pin),
                ),
              ),
              verticalSpace(20),
              SizedBox(
                width: double.infinity.w,
                height: 45.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onPressed: () async {
                    if(formKey.currentState!.validate()){
                      try {
                        PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: MyPhone.verify, smsCode: code);
                        await auth.signInWithCredential(credential);
                      } catch (e) {
                        debugPrint("wrong otp");
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeView(),
                        ),
                      );
                    }
                  },
                  child: const Text(
                      "Verify Phone Number",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      navigateTo(const MyPhone());
                    },
                    child: const Text(
                      "Edit Phone Number ?",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
