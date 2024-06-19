import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tution_notes/Controllers/firebase_auth_controller.dart';
import 'package:tution_notes/Views/Utils/app_colors/app_colors.dart';
import 'package:tution_notes/Views/Utils/app_text/app_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? currentUser;
  String? userName;
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
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 330,
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 220,
                  decoration: BoxDecoration(
                    color: AppColors.primary_color,
                  ),
                  child: Center(
                    child: AppText(
                      title: "Profile",
                      size: 18,
                      color: AppColors.white,
                    ),
                  ),
                ),

                // Profile Section Container
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.15,
                  left: MediaQuery.of(context).size.width * 0.0190,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width / 1.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: AppColors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.greyWithLowOpacity,
                            blurRadius: 4,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: AppColors.primary_color,
                              child: Icon(
                                Icons.person_2,
                                size: 40,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              userName != null ? "${userName}" : 'Loading...',
                            ),
                            Text(
                              currentUser != null
                                  ? "${currentUser!.email}"
                                  : 'example@gmail.com',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Tiles Column
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Tile(
                        Icon(
                          Icons.key_sharp,
                          color: AppColors.white,
                          size: 20,
                        ),
                        'Forget Password',
                      ),
                      SizedBox(height: 10),
                      Tile(
                        Icon(
                          Icons.shopping_cart,
                          size: 20,
                          color: AppColors.white,
                        ),
                        'My Notes',
                        onPress: () {},
                      ),
                      SizedBox(height: 10),
                      Tile(
                        Icon(
                          Icons.file_copy,
                          size: 20,
                          color: AppColors.white,
                        ),
                        'Terms & Conditions',
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Tile(
                    Icon(
                      Icons.logout,
                      size: 20,
                      color: AppColors.white,
                    ),
                    'Logout',
                    onPress: () {
                      controller.logOut();
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget Tile(Widget icon, String text, {onPress}) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 45,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.primary_color,
          shape: BoxShape.circle,
        ),
        child: Center(child: icon),
      ),
      title: AppText(
        title: text,
        size: 12,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 20,
      ),
    );
  }
}
