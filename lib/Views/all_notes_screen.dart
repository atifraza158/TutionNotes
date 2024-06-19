import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tution_notes/Views/Utils/app_colors/app_colors.dart';
import 'package:tution_notes/Views/Utils/app_text/app_text.dart';
import 'package:tution_notes/Views/add_notes_screen.dart';

class AllNotesScreen extends StatelessWidget {
  const AllNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppText(
          title: "All Notes",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {
          Get.to(() => AddNotesScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
