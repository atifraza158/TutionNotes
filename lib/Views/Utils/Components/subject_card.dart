import 'package:flutter/material.dart';
import 'package:tution_notes/Views/Utils/app_colors/app_colors.dart';
import 'package:tution_notes/Views/Utils/app_text/app_text.dart';

class SubjectCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color? cardColor;
  const SubjectCard({
    super.key,
    required this.title,
    required this.imagePath,
    this.cardColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 120,
      decoration: BoxDecoration(
        color: cardColor ?? AppColors.primary_color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppText(
              title: title,
              size: 12,
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
