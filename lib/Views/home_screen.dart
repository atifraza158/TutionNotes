import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tution_notes/Controllers/firebase_auth_controller.dart';
import 'package:tution_notes/Views/Utils/Components/subject_card.dart';
import 'package:tution_notes/Views/Utils/app_colors/app_colors.dart';
import 'package:tution_notes/Views/Utils/app_text/app_text.dart';
import 'package:tution_notes/Views/all_notes_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  FirebaseController firebaseController = Get.put(FirebaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: AppText(
          title: "Home",
          size: 22,
          color: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          IconButton(
            onPressed: () {
              firebaseController.logOut();
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      title: 'Subjects',
                      size: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(() => AllNotesScreen());
                        },
                        child: AppText(
                          title: "See All",
                          size: 12,
                        ))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SubjectCard(
                    title: 'Mathematics',
                    cardColor: AppColors.grey,
                    imagePath: "assets/images/math.png",
                  ),
                  SubjectCard(
                    title: 'Physics',
                    cardColor: AppColors.lightGreen,
                    imagePath: "assets/images/physics.png",
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SubjectCard(
                    title: 'CS',
                    cardColor: AppColors.linear_gradient1,
                    imagePath: "assets/images/computer.png",
                  ),
                  SubjectCard(
                    title: 'Chemistry',
                    cardColor: AppColors.linear_gradient2,
                    imagePath: "assets/images/chemistry.png",
                  ),
                ],
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(10, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: stickyNoteCircle(),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget stickyNoteCircle() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary_color,
      ),
    );
  }
}
