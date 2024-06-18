import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:tution_notes/Controllers/firebase_auth_controller.dart';
import 'package:tution_notes/Views/Utils/app_colors/app_colors.dart';
import 'package:tution_notes/Views/Utils/app_text/app_text.dart';
import 'package:tution_notes/Views/Utils/common_field.dart';
import 'package:tution_notes/Views/Utils/common_button.dart';
import 'forget_password.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  FirebaseController firebaseController = Get.put(FirebaseController());

  bool isLoading = false;
  bool show = false;

  void showPassword() {
    if (show) {
      show = false;
    } else {
      show = true;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    show = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title: 'Sign-in Here!',
                    size: 25,
                    color: AppColors.black,
                  ),
                  AppText(
                    title: 'Sign in your account to continue',
                    size: 12,
                    color: AppColors.grey,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  AppText(
                    title: 'Email Id',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CommonTextField(
                    ketboardType: TextInputType.emailAddress,
                    hintText: "johndoe@example.com",
                    controller: emailcontroller,
                    validate: (val) {
                      if (val!.isEmpty) {
                        return "Email must be given";
                      } else if (!EmailValidator.validate(val)) {
                        return "In-Correct Email Format";
                      } else {
                        return null;
                      }
                    },
                    obsecureText: false,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AppText(title: 'Password'),
                  const SizedBox(
                    height: 5,
                  ),
                  CommonTextField(
                    hintText: "***********",
                    controller: passwordcontroller,
                    ketboardType: TextInputType.text,
                    validate: (val) {
                      if (val!.isEmpty) {
                        return "Password field cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    maxLines: 1,
                    icon: IconButton(
                      icon: show
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      onPressed: showPassword,
                    ),
                    obsecureText: show ? false : true,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ForgetPasswordScreen();
                            },
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: AppText(
                            color: AppColors.primary_color,
                            title: 'Forgot Password',
                            size: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: CommonButton(
                      child: Obx(
                        () => firebaseController.loader.value
                            ? CircularProgressIndicator(
                                color: AppColors.white,
                              )
                            : AppText(
                                title: 'Login',
                                size: 18,
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                      ),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          firebaseController.signInWithEmailAndPassword(
                            emailcontroller.text,
                            passwordcontroller.text,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  title: "Don't have an account?",
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return RegisterScreen();
                      },
                    ));
                  },
                  child: AppText(
                    title: 'SignUp',
                    size: 12,
                    color: AppColors.primary_color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
