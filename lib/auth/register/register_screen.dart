import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talabat_user/core/design/loading_manager.dart';
import '../../core/design/app_button.dart';
import '../../core/design/app_input.dart';
import '../../core/design/app_name_text.dart';
import '../../core/design/title_text.dart';
import '../../core/logic/helper_methods.dart';
import '../../core/regex/app_regex.dart';
import '../../core/utils/spacing.dart';
import '../../core/utils/text_styles.dart';
import '../../view/home/pages/profile/widget/my_app_methods.dart';
import '../login/login_screen.dart';
import 'widget/pick_image_dialogs.dart';
import 'widget/pick_image_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  final fullNameFocusNode = FocusNode();
  XFile? pickedImage;
  bool isLoading = false;
  final auth = FirebaseAuth.instance;


  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await PickImageDialogs.imagePickDialogs(
      context: context,
      cameraFunction: () async {
        pickedImage = await picker.pickImage(source: ImageSource.camera);
        setState(() {});
      },
      galleryFunction: () async {
        pickedImage = await picker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      removeFunction: () {
        setState(() {
          pickedImage = null;
        });
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  style: TextStyles.textStyle20Bold.copyWith(
                    fontSize: 25.sp,
                  ),
                ),
              ),
              verticalSpace(25),
              TitleTextWidget(
                label: "Welcome",
                textStyle: TextStyles.textStyle20Bold,
              ),
              verticalSpace(5),
              TitleTextWidget(
                label: "Sign up now to receive special offers & updates\nfrom our app",
                maxLines: 2,
                textStyle: TextStyles.textStyle18Normal.copyWith(
                  fontSize: 15.sp,
                ),
              ),
              verticalSpace(30),
              Center(
                child: SizedBox(
                  height: size.width * 0.3,
                  width: size.width * 0.3,
                  child: PickImageWidget(
                    pickedImage: pickedImage,
                    function: () async{
                        await localImagePicker();
                    },
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    AppInput(
                      hintText: "FullName",
                      textStyle: const TextStyle(color: Colors.grey),
                      textInputAction: TextInputAction.next,
                      paddingTop: 40,
                      focusNode: fullNameFocusNode,
                      onChanged: (value) {},
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(emailFocusNode);
                      },
                      iconData: IconlyLight.user3,
                      controller: fullNameController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !AppRegex.isUserNameValid(value)) {
                          return "برجاء ادخال اسمك ثنائي";
                        }
                        return null;
                      },
                      type: TextInputType.name,
                      enableBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    AppInput(
                      hintText: "Email address",
                      textStyle: const TextStyle(color: Colors.grey),
                      textInputAction: TextInputAction.next,
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
                          return "بريدك الالكتروني غير صالح";
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
                      textInputAction: TextInputAction.next,
                      focusNode: passwordFocusNode,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
                      },
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
                      enableBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    AppInput(
                      hintText: "Confirm Password",
                      textStyle: const TextStyle(color: Colors.grey),
                      textInputAction: TextInputAction.done,
                      focusNode: confirmPasswordFocusNode,
                      iconData: IconlyLight.lock,
                      controller: confirmPasswordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null ||
                            value != passwordController.text ||
                            value.isEmpty ||
                            !AppRegex.isPasswordValid(value)) {
                          return "كلمه المرور غير متطابقه";
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
              verticalSpace(15),
              AppButton(
                buttonStyle: FilledButton.styleFrom(
                  fixedSize: Size(double.infinity.w, 50.h),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                text: "Sign up",
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
                      await auth.createUserWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                      Fluttertoast.showToast(
                        msg: "An account has been created",
                        toastLength: Toast.LENGTH_SHORT,
                        textColor: Colors.white,
                      );
                      navigateTo(const LoginScreen());
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
                  if (pickedImage == null) {
                    MyAppMethods.showErrorORWarningDialog(
                        context: context,
                        subtitle: "Make sure to pick up an image",
                        function: () {},
                    );
                  }
                },
              ),
              verticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TitleTextWidget(
                    label: "Already have an account?  ",
                    textStyle: TextStyles.textStyle18Normal.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateTo(const LoginScreen());
                    },
                    child: TitleTextWidget(
                      label: "Sign in",
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
