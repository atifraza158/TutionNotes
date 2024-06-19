import 'package:flutter/material.dart';
import 'package:tution_notes/Views/Utils/app_colors/app_colors.dart';

class NoteUpdateSheet extends StatelessWidget {
  const NoteUpdateSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
    );
  }
}
