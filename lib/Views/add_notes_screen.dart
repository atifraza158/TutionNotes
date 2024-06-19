import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:tution_notes/Controllers/firestore_controller.dart';
import 'package:tution_notes/Views/Dashboard/dashboard.dart';
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
  final notesTitleController = TextEditingController();
  FirestoreController firestoreController = Get.put(FirestoreController());
  var dropdownValue = '';
  final key = GlobalKey<FormState>();

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
          padding: const EdgeInsets.all(20),
          child: Form(
            key: key,
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
                  controller: notesTitleController,
                  validate: (val) {
                    if (val == null) {
                      return 'Field cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  hintText: 'Title',
                  obsecureText: false,
                ),
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
                SizedBox(height: 10),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Subjects')
                      .snapshots(),
                  builder: (context, snapshot) {
                    List<DropdownMenuItem> subjectsList = [];
                    if (snapshot.hasData) {
                      final subjects = snapshot.data!.docs.reversed.toList();
                      subjectsList.add(
                        DropdownMenuItem(
                          child: AppText(
                            title: 'Select Subject',
                            size: 11,
                          ),
                          value: '',
                        ),
                      );
                      for (var subject in subjects) {
                        subjectsList.add(DropdownMenuItem(
                          child: AppText(title: subject['subject_name']),
                          value: subject.id,
                        ));
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            title: "Subjects",
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: AppColors.primary_color),
                            ),
                            child: DropdownButton(
                                padding: EdgeInsets.only(left: 8),
                                value: dropdownValue,
                                items: subjectsList,
                                isExpanded: false,
                                underline: SizedBox(),
                                style: new TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                                onChanged: (subjectVal) {
                                  setState(() {
                                    dropdownValue = subjectVal;
                                  });
                                  print(dropdownValue);
                                }),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary_color,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CommonButton(
          child: Obx(
            () => firestoreController.loader.value
                ? CircularProgressIndicator(
                    color: AppColors.white,
                  )
                : AppText(
                    title: 'Add Note',
                    size: 18,
                    color: AppColors.white,
                  ),
          ),
          onPressed: () async {
            String id = randomAlphaNumeric(7);
            Map<String, dynamic> notesDetails = {
              'id': id,
              'note_title': notesTitleController.text,
              'note': notesController.text.toString(),
              'subject': dropdownValue,
              'created_at': Timestamp.now()
            };

            await firestoreController
                .addData(notesDetails, id, 'Notes')
                .then((_) => {
                      Get.snackbar('Success', 'Note Saved Successfully'),
                      Get.off(() => Dashboard()),
                    });
          },
        ),
      ),
    );
  }

  File? file;
  var name;
  String? url;

  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    if (result != null) {
      File c = File(result.files.single.path.toString());
      setState(() {
        file = c;
        name = result.names.toString();
      });
      print(file);
    }
  }

  uploadFile() async {
    try {
      var myFile =
          FirebaseStorage.instance.ref().child('Notes').child('/$name');
      UploadTask task = myFile.putFile(file!);
      TaskSnapshot snapshot = await task;
      url = await snapshot.ref.getDownloadURL();
      print(url);
      if (url != null && file != null) {
        Get.snackbar('Success', 'Notes Successfully Saved');
      }
    } catch (e) {}
  }
}
