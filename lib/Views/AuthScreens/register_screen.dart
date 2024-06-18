import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tution_notes/Views/Utils/common_button.dart';
import 'package:tution_notes/Views/Utils/common_field.dart';

import '../../Controllers/firebase_auth_controller.dart';
import '../Utils/app_colors/app_colors.dart';
import '../Utils/app_text/app_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var cpasswordcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  FirebaseController firebaseController = Get.put(FirebaseController());

  String? matchPassword(value) {
    if (value!.isEmpty) {
      return 'Confirm Password Field must be filled';
    } else if (passwordcontroller.text.toString() !=
        cpasswordcontroller.text.toString()) {
      return "Password not match";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Center(
              child: Form(
                key: _formkey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        title: 'Create account',
                        size: 25,
                      ),
                      AppText(
                        title: 'Sign up to begin your jounery',
                        size: 10,
                        color: AppColors.grey,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      AppText(
                        title: 'Full name',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CommonTextField(
                        controller: namecontroller,
                        ketboardType: TextInputType.text,
                        validate: (val) {
                          if (val!.isEmpty) {
                            return "Name Field cannot be empty";
                          } else {
                            return null;
                          }
                        },
                        obsecureText: false,
                        hintText: 'Your name here',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppText(
                        title: 'Email',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CommonTextField(
                        controller: emailcontroller,
                        hintText: "abc@example.com",
                        ketboardType: TextInputType.emailAddress,
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
                        height: 20,
                      ),
                      AppText(
                        title: 'Password',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CommonTextField(
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
                        obsecureText: true,
                        hintText: 'Type pasword here',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Confrim Password',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CommonTextField(
                        controller: cpasswordcontroller,
                        obsecureText: true,
                        hintText: "Confirm Password",
                        ketboardType: TextInputType.text,
                        validate: matchPassword,
                        maxLines: 1,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: CommonButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              firebaseController.createUserWithEmailAndPassword(
                                  emailcontroller.text,
                                  passwordcontroller.text,
                                  namecontroller.text);
                            }
                          },
                          child: Obx(
                            () => firebaseController.loader.value
                                ? CircularProgressIndicator(
                                    color: AppColors.white,
                                  )
                                : AppText(
                                    title: 'Sign-Up',
                                    size: 18,
                                    color: AppColors.white,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                  title: "Alread a member?",
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: AppText(
                    title: "Sign-In",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
