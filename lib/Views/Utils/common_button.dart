import 'package:flutter/material.dart';
import 'package:tution_notes/Views/Utils/app_colors/app_colors.dart';

class CommonButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  const CommonButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: AppColors.primary_color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              offset: Offset(0, 10),
              blurRadius: 20,
            ),
          ],
          gradient: LinearGradient(
            colors: [
              AppColors.linear_gradient1,
              AppColors.linear_gradient2,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
