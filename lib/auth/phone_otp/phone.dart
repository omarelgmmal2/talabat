import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabat_user/auth/phone_otp/verfiy.dart';
import 'package:talabat_user/core/design/app_image.dart';
import 'package:talabat_user/core/logic/helper_methods.dart';
import 'package:talabat_user/core/utils/spacing.dart';

import '../../core/regex/app_regex.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({super.key});

  static String verify = "";

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countryController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var phone = "";

  @override
  void initState() {
    countryController.text = "+20";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
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
              Container(
                height: 55.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.w,
                      color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Form(
                  key: formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      horizontalSpace(10),
                      SizedBox(
                        width: 40.w,
                        child: TextField(
                          controller: countryController,
                          onChanged: (value) {
                            phone = value;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Text(
                        "|",
                        style: TextStyle(fontSize: 33.sp, color: Colors.grey,),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !AppRegex.isPhoneNumberValid(value)) {
                              return "رقم الهاتف مطلوب";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                          ),
                        ),
                      )
                    ],
                  ),
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
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: countryController.text + phone,
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          MyPhone.verify = verificationId;
                          navigateTo(const MyVerify());
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    }
                  },
                  child: const Text(
                      "Send the code",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
