import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tution_notes/Controllers/firestore_controller.dart';
import 'package:tution_notes/Views/Utils/Components/note_card.dart';
import 'package:tution_notes/Views/Utils/app_colors/app_colors.dart';
import 'package:tution_notes/Views/Utils/app_text/app_text.dart';
import 'package:tution_notes/Views/add_notes_screen.dart';

class AllNotesScreen extends StatefulWidget {
  const AllNotesScreen({super.key});

  @override
  State<AllNotesScreen> createState() => _AllNotesScreenState();
}

class _AllNotesScreenState extends State<AllNotesScreen> {
  FirestoreController firestoreController = Get.put(FirestoreController());
  String selectedSubjectId = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          title: 'All Notes',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Subjects')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<QueryDocumentSnapshot> subjects = snapshot.data!.docs;
                    if (selectedSubjectId.isEmpty) {
                      selectedSubjectId = subjects.first.id;
                    }
                    return Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: subjects.map((subject) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSubjectId = subject.id;
                                  });
                                  FirebaseFirestore.instance
                                      .collection('Subjects')
                                      .where('id', isEqualTo: subject.id)
                                      .get()
                                      .then((querySnapshot) {
                                    List<QueryDocumentSnapshot> notes =
                                        querySnapshot.docs;
                                    return NoteCard(notes: notes);
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 14),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: subject.id == selectedSubjectId
                                          ? AppColors.primary_color
                                          : AppColors.white,
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          subject['subject_name'],
                                          style: subject.id == selectedSubjectId
                                              ? TextStyle(
                                                  color: AppColors.white,
                                                  fontSize: 11,
                                                )
                                              : TextStyle(
                                                  color: AppColors.black,
                                                  fontSize: 11),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        // Display the items in a GridView
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('Notes')
                              .where('subject', isEqualTo: selectedSubjectId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<QueryDocumentSnapshot> notes =
                                  snapshot.data!.docs;

                              return NoteCard(notes: notes);
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ],
                    );
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      color: AppColors.primary_color,
                    ));
                  }
                },
              )
            ],
          ),
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
