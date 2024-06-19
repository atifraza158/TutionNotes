import 'package:flutter/material.dart';
import 'package:tution_notes/Views/Utils/app_colors/app_colors.dart';
import 'package:tution_notes/Views/Utils/app_text/app_text.dart';

class SubjectCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color? cardColor;
  final VoidCallback onPressed;
  const SubjectCard({
    super.key,
    required this.title,
    required this.imagePath,
    this.cardColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 180,
        height: 120,
        decoration: BoxDecoration(
          color: cardColor ?? AppColors.primary_color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            AppText(
              title: title,
              size: 12,
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }
}
