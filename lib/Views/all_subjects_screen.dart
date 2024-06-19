import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tution_notes/Controllers/firestore_controller.dart';
import 'package:tution_notes/Views/Utils/app_colors/app_colors.dart';
import 'package:tution_notes/Views/Utils/app_text/app_text.dart';
import 'package:tution_notes/Views/add_subject.dart';

class AllSubjectsScreen extends StatefulWidget {
  const AllSubjectsScreen({super.key});

  @override
  State<AllSubjectsScreen> createState() => _AllSubjectsScreenState();
}

class _AllSubjectsScreenState extends State<AllSubjectsScreen> {
  FirestoreController firestoreController = Get.put(FirestoreController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          title: 'All Subjects',
          size: 18,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Subjects').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(snapshot.data!.docs.length, (index) {
                    DocumentSnapshot subjects = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.primary_color,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.greyWithLowOpacity,
                              blurRadius: 4,
                              offset: Offset(4, 8),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(8),
                          leading: CircleAvatar(
                            backgroundColor: AppColors.white,
                            backgroundImage: NetworkImage(subjects['image']),
                          ),
                          title: AppText(
                            title: subjects['subject_name'],
                            color: AppColors.white,
                            size: 12,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
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
                                        title: "${subjects['subject_name']}",
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
                                                .deleteData(
                                              '${subjects['id']}',
                                              'Subjects',
                                            )
                                                .then((_) {
                                              Get.back();
                                              Get.snackbar(
                                                'Success',
                                                'Subject removed Successfully',
                                              );
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
                      ),
                    );
                  }),
                ),
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
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.linear_gradient1,
          foregroundColor: AppColors.white,
        ),
        onPressed: () {
          Get.to(() => AddSubject());
        },
        child: AppText(
          title: 'Add Subject',
          color: AppColors.white,
        ),
      ),
    );
  }
}
