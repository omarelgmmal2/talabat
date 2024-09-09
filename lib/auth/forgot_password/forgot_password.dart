import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabat_user/core/utils/spacing.dart';

import '../../core/regex/app_regex.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        myDialogBox(context);
      },
      child: Text(
        textAlign: TextAlign.right,
        "Forgot Password?",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
          color: Colors.blue,
        ),
      ),
    );
  }

  void myDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text(
                      "Forgot Your Password",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                verticalSpace(20),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !AppRegex.isEmailValid(value)) {
                      return "بريدك الالكتروني غير صحيح";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    labelText: "Enter the Email",
                    hintText: "eg abc@gmail.com",
                  ),
                ),
                verticalSpace(20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () async {
                    await auth
                        .sendPasswordResetEmail(email: emailController.text)
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "We have send you the reset password link to your email id, Please check it",
                          ),
                        ),
                      );
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            error.toString(),
                          ),
                        ),
                      );
                    });
                    Navigator.pop(context);
                    emailController.clear();
                  },
                  child: Text(
                    "Send",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
