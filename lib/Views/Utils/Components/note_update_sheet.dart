import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tution_notes/Controllers/firestore_controller.dart';
import 'package:tution_notes/Views/Utils/app_colors/app_colors.dart';
import 'package:tution_notes/Views/Utils/app_text/app_text.dart';
import 'package:tution_notes/Views/Utils/common_button.dart';
import 'package:tution_notes/Views/Utils/common_field.dart';

class NoteUpdateSheet extends StatefulWidget {
  NoteUpdateSheet({
    super.key,
    required this.noteTitle,
    required this.note,
    required this.id,
    required this.subjectID,
  });
  final String noteTitle;
  final String note;
  final String id;
  final String subjectID;

  @override
  State<NoteUpdateSheet> createState() => _NoteUpdateSheetState();
}

class _NoteUpdateSheetState extends State<NoteUpdateSheet> {
  final noteTitleController = TextEditingController();
  final noteController = TextEditingController();
  FirestoreController firestoreController = Get.put(FirestoreController());

  @override
  void initState() {
    noteTitleController.text = widget.noteTitle;
    noteController.text = widget.note;
    super.initState();
  }

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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  title: widget.noteTitle,
                  size: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              CommonTextField(
                controller: noteTitleController,
                hintText: 'Title',
                validate: (val) {
                  if (val == null) {
                    return "Field cannot be empty";
                  } else {
                    return null;
                  }
                },
                obsecureText: false,
              ),
              SizedBox(height: 10),
              CommonTextField(
                controller: noteController,
                hintText: 'note',
                validate: (val) {
                  if (val == null) {
                    return "Field cannot be empty";
                  } else {
                    return null;
                  }
                },
                obsecureText: false,
              ),
              SizedBox(height: 30),
              CommonButton(
                child: Obx(
                  () => firestoreController.loader.value
                      ? CircularProgressIndicator(
                          color: AppColors.white,
                        )
                      : AppText(
                          title: "Update",
                          size: 18,
                          color: AppColors.white,
                        ),
                ),
                onPressed: () {
                  Map<String, dynamic> noteData = {
                    'id': widget.id,
                    'note_title': noteTitleController.text,
                    'note': noteController.text,
                    'created_at': Timestamp.now(),
                    'subject': widget.subjectID,
                  };

                  firestoreController.UpdateData(widget.id, noteData, 'Notes')
                      .then((_) {
                    Get.snackbar('Success', 'Note Updated Successfully');
                    // Get.back();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
