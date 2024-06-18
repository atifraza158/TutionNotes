import 'package:flutter/material.dart';
import 'package:tution_notes/Views/Utils/app_colors/app_colors.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? ketboardType;
  final String? hintText;
  final Widget? icon;
  final String? Function(String?)? validate;
  final bool obsecureText;
  final int? maxLines;

  const CommonTextField({
    super.key,
    this.icon,
    required this.controller,
    this.ketboardType,
    this.hintText,
    required this.validate,
    required this.obsecureText,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText,
      controller: controller,
      keyboardType: ketboardType,
      cursorColor: AppColors.primary_color,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'poppins'),
        suffixIcon: icon,
        focusColor: Colors.grey,
        fillColor: AppColors.white,
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.primary_color,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: AppColors.primary_color,
            )),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: validate,
      maxLines: maxLines,
    );
  }
}
