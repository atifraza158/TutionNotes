import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:tution_notes/Views/Utils/app_button/app_button.dart';
import 'package:tution_notes/Views/Utils/app_colors/app_colors.dart';
import 'package:tution_notes/Views/Utils/app_text/app_text.dart';

import '../Utils/common_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                AppText(
                  title: 'Forgot password',
                  size: 9,
                  color: AppColors.primary_color,
                ),
                const SizedBox(
                  height: 5,
                ),
                AppText(
                  title: 'Enter your email to forgot password',
                  color: AppColors.grey,
                  size: 11,
                ),
                const SizedBox(
                  height: 20,
                ),
                CommonTextField(
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
                  hintText: 'johndoe@example.com',
                ),
                const SizedBox(
                  height: 25,
                ),
                AppButton(
                  onTap: () {},
                  buttonName: 'Submit',
                ),
              ],
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info,
                  color: Colors.grey,
                  size: 30,
                ),
                SizedBox(width: 10),
                Flexible(
                  child: AppText(
                    title:
                        "You will recieve an email that will caontain a token to recover the forgot password!",
                    softWrap: true,
                    overFlow: TextOverflow.visible,
                    color: AppColors.grey,
                    size: 10,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
