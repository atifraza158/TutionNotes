import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tution_notes/Controllers/firestore_controller.dart';
import 'package:tution_notes/Views/Utils/Components/note_update_sheet.dart';
import 'package:tution_notes/Views/Utils/app_text/app_text.dart';

import 'Utils/app_colors/app_colors.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class NotesDetailScreen extends StatelessWidget {
  final String id;
  NotesDetailScreen({
    super.key,
    required this.id,
  });

  FirestoreController firestoreController = Get.put(FirestoreController());
  String noteTitle = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          title: 'Note Details',
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('Notes').doc(id).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var note = snapshot.data!.data();
            noteTitle = note!['note_title'];
            Timestamp timestamp = note['created_at'];
            DateTime dateTime = timestamp.toDate();
            // Format the DateTime object to a readable string
            String formattedDate =
                DateFormat('yyyy-MM-dd - kk:mm').format(dateTime);
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title: note['note_title'],
                    size: 20,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 8),
                  AppText(
                    title: formattedDate,
                    size: 10,
                    color: AppColors.grey,
                  ),
                  SizedBox(height: 5),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('Subjects')
                        .doc(note['subject'])
                        .get(),
                    builder: (context, snapshot) {
                      var subject = snapshot.data!.data();
                      if (snapshot.connectionState != ConnectionState.waiting) {
                        if (snapshot.hasData) {
                          return AppText(
                            title:
                                'Note is associated with ${subject!['subject_name']} Subject',
                            size: 11,
                            color: AppColors.grey,
                          );
                        } else {
                          return AppText(
                            title: 'Loading...',
                          );
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  AppText(
                    title: note['note'],
                    size: 12,
                  ),
                ],
              ),
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
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary_color,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.delete, size: 20),
              onPressed: () {
                Get.dialog(AlertDialog(
                  content: Text(
                    "Are you sure you want to delete this?",
                  ),
                  title: AppText(
                    title: "${noteTitle}",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text("No"),
                    ),
                    TextButton(
                      onPressed: () {
                        firestoreController.deleteData(id, 'Notes').then((_) {
                          Get.back();
                        });
                      },
                      child: Text("Yes"),
                    ),
                  ],
                ));
              },
              color: AppColors.white,
            ),
          ),
          SizedBox(width: 5),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary_color,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.edit, size: 20),
              onPressed: () {
                Get.bottomSheet(NoteUpdateSheet());
              },
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
