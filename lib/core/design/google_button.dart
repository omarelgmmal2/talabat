import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:talabat_user/view/home/home_screen.dart';
import 'google_auth.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      icon: const Icon(
        Ionicons.logo_google,
        color: Colors.red,
      ),
      label: Text(
        "Sign in with google",
        style: TextStyle(
          fontSize: 16.0.sp,
          color: Colors.black,
        ),
      ),
      onPressed: () async{
        await FirebaseServices().signInWithGoogle();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeView(),
          ),
        );
      },
    );
  }
}
