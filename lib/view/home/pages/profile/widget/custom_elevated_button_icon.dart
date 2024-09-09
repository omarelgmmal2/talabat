import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talabat_user/core/logic/helper_methods.dart';
import '../../../../../auth/login/login_screen.dart';
import 'my_app_methods.dart';

class CustomElevatedButtonIcon extends StatefulWidget {
  const CustomElevatedButtonIcon({super.key});

  @override
  State<CustomElevatedButtonIcon> createState() => _CustomElevatedButtonIconState();
}

class _CustomElevatedButtonIconState extends State<CustomElevatedButtonIcon> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
      onPressed: () async{
        if (user == null) {
          navigateTo(const LoginScreen());
        } else {
          await MyAppMethods.showErrorORWarningDialog(
            context: context,
            subtitle: "Are you sure?",
            function: () async {
              await FirebaseAuth.instance.signOut();
              if (!mounted) return;
              navigateTo(const LoginScreen());
            },
            isError: false,
          );
        }
        await MyAppMethods.showErrorORWarningDialog(
          context: context,
          subtitle: "Are you sure?",
          function: () {},
          isError: false,
        );
      },
      icon: Icon(user == null ? Icons.login : Icons.logout),
      label: Text(
        user == null ? "Login" : "Logout",
      ),
    );
  }
}
