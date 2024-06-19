import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tution_notes/Controllers/firestore_controller.dart';
import 'package:tution_notes/Views/Utils/app_colors/app_colors.dart';
import 'package:tution_notes/Views/Utils/app_text/app_text.dart';
import 'package:tution_notes/Views/Utils/common_button.dart';
import 'package:tution_notes/Views/Utils/common_field.dart';

class AddNotesScreen extends StatefulWidget {
  AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  final notesController = TextEditingController();
  FirestoreController firestoreController = Get.put(FirestoreController());
  var dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title: "Add a New Note",
                size: 25,
                fontWeight: FontWeight.w600,
              ),
              AppText(
                title: 'Associate with Subject',
                color: AppColors.grey,
              ),
              SizedBox(height: 20),
              CommonTextField(
                controller: notesController,
                validate: (val) {
                  if (val == null) {
                    return 'Field cannot be empty';
                  } else {
                    return null;
                  }
                },
                hintText: 'anything here...',
                maxLines: 4,
                obsecureText: false,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Subjects')
                    .snapshots(),
                builder: (context, snapshot) {
                  List<DropdownMenuItem> subjectsList = [];
                  if (snapshot.hasData) {
                    final subjects = snapshot.data!.docs.reversed.toList();
                    subjectsList.add(DropdownMenuItem(
                      child: AppText(
                        title: 'Select Subject',
                      ),
                      value: '',
                    ));
                    for (var subject in subjects) {
                      subjectsList.add(DropdownMenuItem(
                        child: AppText(title: subject['subject_name']),
                        value: subject.id,
                      ));
                    }
                    return DropdownButton(
                        value: dropdownValue,
                        items: subjectsList,
                        isExpanded: false,
                        onChanged: (subjectVal) {
                          setState(() {
                            dropdownValue = subjectVal;
                          });
                          print(subjectVal);
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary_color,
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CommonButton(
          child: AppText(
            title: 'Add Note',
            size: 18,
            color: AppColors.white,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
