import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tution_notes/Views/Utils/app_text/app_text.dart';

import '../../../Controllers/firestore_controller.dart';
import '../../notes_detail_screen.dart';
import '../app_colors/app_colors.dart';

// ignore: must_be_immutable
class NoteCard extends StatelessWidget {
  final List<QueryDocumentSnapshot> notes;
  NoteCard({
    super.key,
    required this.notes,
  });

  FirestoreController firestoreController = Get.put(FirestoreController());
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.75,
      ),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              Get.to(
                () => NotesDetailScreen(
                  id: notes[index]['id'],
                ),
              );
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 200),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary_color,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.greyWithLowOpacity,
                          blurRadius: 4,
                          offset: Offset(4, 8),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppText(
                            title: '${notes[index]['note_title']}',
                            color: AppColors.white,
                            size: 12,
                          ),
                          Text(
                            '${notes[index]['note']}',
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.edit, size: 20),
                          onPressed: () {},
                          color: AppColors.primary_color,
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.white,
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
                                title: "${notes[index]['note_title']}",
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
                                    firestoreController
                                        .deleteData(notes[index]['id'], 'Notes')
                                        .then((_) {
                                      Get.back();
                                    });
                                  },
                                  child: Text("Yes"),
                                ),
                              ],
                            ));
                          },
                          color: AppColors.primary_color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
