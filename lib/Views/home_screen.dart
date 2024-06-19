import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tution_notes/Controllers/firebase_auth_controller.dart';
import 'package:tution_notes/Views/Utils/Components/note_card.dart';
import 'package:tution_notes/Views/Utils/app_colors/app_colors.dart';
import 'package:tution_notes/Views/Utils/app_text/app_text.dart';
import 'package:tution_notes/Views/all_notes_screen.dart';
import 'package:tution_notes/Views/all_subjects_screen.dart';
import 'package:tution_notes/Views/subject_card_data.dart';
import 'package:tution_notes/Views/subject_card_data2.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseController firebaseController = Get.put(FirebaseController());
  User? currentUser;
  String? userName;
  String selectedSubjectId = '';
  FirebaseController controller = Get.put(FirebaseController());
  checkUser() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        currentUser = user;
        if (currentUser != null) {
          FirebaseFirestore.instance
              .collection('auth')
              .doc(currentUser!.uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              setState(() {
                userName = documentSnapshot['name'];
              });
            }
          });
        }
      });
    });
  }

  @override
  void initState() {
    checkUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.primary_color,
                            radius: 35,
                            child: Icon(Icons.person_2_rounded),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                title: userName != null
                                    ? "${userName}"
                                    : 'Loading...',
                                size: 13,
                              ),
                              AppText(
                                title: currentUser != null
                                    ? "${currentUser!.email}"
                                    : 'example@gmail.com',
                                size: 10,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.sizeOf(context).height / 2,
                  width: MediaQuery.sizeOf(context).width,
                  // color: AppColors.greyWithLowOpacity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      drawerTile('Home', Icons.home, () {
                        Get.back();
                      }),
                      drawerTile('Notes', Icons.note_add_sharp, () {
                        Get.to(() => AllNotesScreen());
                      }),
                      drawerTile('Subjects', Icons.book, () {
                        Get.to(() => AllSubjectsScreen());
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: drawerTile('Logout', Icons.logout, () {
                    firebaseController.logOut();
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: AppText(
          title: "Home",
          size: 22,
          color: AppColors.black,
          fontWeight: FontWeight.w600,
        ),
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
                          Get.to(() => AllSubjectsScreen());
                        },
                        child: AppText(
                          title: "See All",
                          size: 12,
                        ))
                  ],
                ),
              ),
              SubjectCardData(),
              SizedBox(height: 10),
              SubjectCardData2(),
              // SizedBox(
              //   height: 400,
              //   child: StreamBuilder(
              //     stream: FirebaseFirestore.instance
              //         .collection('Subjects')
              //         .snapshots(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasData) {
              //         return GridView.builder(
              //           physics: NeverScrollableScrollPhysics(),
              //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //             crossAxisCount: 2,
              //           ),
              //           itemCount: 4,
              //           itemBuilder: (context, index) {
              //             DocumentSnapshot subjects =
              //                 snapshot.data!.docs[index];
              //             return Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: SubjectCard(
              //                 title: subjects['subject_name'],
              //                 imagePath: subjects['image'],
              //                 onPressed: () {},
              //                 cardColor: colors[index],
              //               ),
              //             );
              //           },
              //         );
              //       } else {
              //         return Center(
              //           child: CircularProgressIndicator(
              //             color: AppColors.primary_color,
              //           ),
              //         );
              //       }
              //     },
              //   ),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     SubjectCard(
              //       onPressed: () {
              //         // Get.to(() => MathNotes());
              //       },
              //       title: 'Mathematics',
              //       cardColor: AppColors.grey,
              //       imagePath: "assets/images/math.png",
              //     ),
              //     SubjectCard(
              //       onPressed: () {
              //         // Get.to(() => PhysicsNotes());
              //       },
              //       title: 'Physics',
              //       cardColor: AppColors.lightGreen,
              //       imagePath: "assets/images/physics.png",
              //     ),
              //   ],
              // ),
              // SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     SubjectCard(
              //       onPressed: () {
              //         // Get.to(() => CsNotes());
              //       },
              //       title: 'CS',
              //       cardColor: AppColors.linear_gradient1,
              //       imagePath: "assets/images/computer.png",
              //     ),
              //     SubjectCard(
              //       onPressed: () {
              //         // Get.to(() => ChemistryNotes());
              //       },
              //       title: 'Chemistry',
              //       cardColor: AppColors.linear_gradient2,
              //       imagePath: "assets/images/chemistry.png",
              //     ),
              //   ],
              // ),
              SizedBox(height: 15),
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
                              return Center(
                                  child: CircularProgressIndicator(
                                color: AppColors.primary_color,
                              ));
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

  List colors = [
    AppColors.grey,
    Colors.lightGreen,
    AppColors.linear_gradient1,
    AppColors.linear_gradient2,
  ];

  Widget drawerTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      title: AppText(
        title: title,
        size: 13,
      ),
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: AppColors.primary_color,
        child: Icon(
          icon,
          size: 15,
        ),
      ),
    );
  }
}
