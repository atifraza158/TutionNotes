import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tution_notes/Views/AuthScreens/auth_check.dart';
import 'package:tution_notes/Views/Utils/app_colors/app_colors.dart';
import 'package:tution_notes/Views/Utils/app_text/app_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Get.offAll(() => CheckAuth());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary_color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText(
              title: "StudyScript",
              color: AppColors.white,
              size: 32,
              fontWeight: FontWeight.w500,
            ),
            AppText(
              title: 'Your Study Mate',
              color: AppColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
