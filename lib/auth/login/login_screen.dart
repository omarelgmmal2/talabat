import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:talabat_user/core/design/loading_manager.dart';
import '../../core/design/app_button.dart';
import '../../core/design/app_input.dart';
import '../../core/design/app_name_text.dart';
import '../../core/design/google_button.dart';
import '../../core/design/title_text.dart';
import '../../core/logic/helper_methods.dart';
import '../../core/regex/app_regex.dart';
import '../../core/utils/spacing.dart';
import '../../core/utils/text_styles.dart';
import '../../view/home/home_screen.dart';
import '../../view/home/pages/profile/widget/my_app_methods.dart';
import '../forgot_password/forgot_password.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManager(
        isLoading: isLoading,
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            children: [
              Center(
                child: AppNameText(
                  text: "ShopSmart",
                  style: TextStyles.textStyle20Bold.copyWith(fontSize: 25),
                ),
              ),
              verticalSpace(25),
              TitleTextWidget(
                label: "Welcome Back",
                textStyle: TextStyles.textStyle20Bold,
              ),
              verticalSpace(5),
              TitleTextWidget(
                label: "Let's get you logged in so you can start exploring",
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
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(passwordFocusNode);
                      },
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
                    AppInput(
                      hintText: "Password",
                      textStyle: const TextStyle(color: Colors.grey),
                      textInputAction: TextInputAction.done,
                      focusNode: passwordFocusNode,
                      iconData: IconlyLight.lock,
                      controller: passwordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !AppRegex.isPasswordValid(value)) {
                          return "كلمه المرور غير صحيحه";
                        }
                        return null;
                      },
                      type: TextInputType.visiblePassword,
                      paddingBottom: 20,
                      enableBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ],
                ),
              ),
              const ForgotPassword(),
              verticalSpace(30),
              AppButton(
                buttonStyle: FilledButton.styleFrom(
                  fixedSize: Size(double.infinity.w, 50.h),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                text: "Sign in",
                textStyle: TextStyles.textStyle18Normal.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                onPress: () async{
                  if (formKey.currentState!.validate()){
                    try {
                      setState(() {
                        isLoading = true;
                      });
                      await auth.signInWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                      Fluttertoast.showToast(
                        msg: "Login Successful",
                        toastLength: Toast.LENGTH_SHORT,
                        textColor: Colors.white,
                      );
                      if (!mounted) return;

                      navigateTo(const HomeView());
                    } on FirebaseAuthException catch (error) {
                      await MyAppMethods.showErrorORWarningDialog(
                        context: context,
                        subtitle: "An error has been occured ${error.message}",
                        function: () {},
                      );
                    } catch (error) {
                      await MyAppMethods.showErrorORWarningDialog(
                        context: context,
                        subtitle: "An error has been occured $error",
                        function: () {},
                      );
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
                  FocusScope.of(context).unfocus();
                },
              ),
              verticalSpace(20),
              TitleTextWidget(
                label: "OR CONNECT USING",
                textStyle: TextStyles.textStyle18Normal.copyWith(
                  fontSize: 16.sp,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              verticalSpace(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: kBottomNavigationBarHeight.h,
                      child: const FittedBox(
                        child: GoogleButton(),
                      ),
                    ),
                  ),
                  horizontalSpace(8),
                  Expanded(
                    child: SizedBox(
                      height: kBottomNavigationBarHeight.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.all(12),
                          // backgroundColor:
                          // Theme.of(context).colorScheme.background,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          "Guest",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TitleTextWidget(
                    label: "Don't have an account?  ",
                    textStyle: TextStyles.textStyle18Normal.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateTo(const RegisterScreen());
                    },
                    child: TitleTextWidget(
                      label: "Sign up",
                      textStyle: TextStyles.textStyle18Normal.copyWith(
                        decoration: TextDecoration.underline,
                        fontSize: 16.sp,
                      ),
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
