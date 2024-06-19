import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tution_notes/Views/AuthScreens/login_screen.dart';
import 'package:tution_notes/Views/Dashboard/dashboard.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Dashboard();
          // final User? user = snapshot.data;
          // final String uid = user!.uid;
          // final FirebaseFirestore firestore = FirebaseFirestore.instance;
          // final DocumentReference documentReference =
          //     firestore.collection('auth').doc(uid);
          // return StreamBuilder(
          //   stream: documentReference.snapshots(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       final DocumentSnapshot<Object?>? documentSnapshot =
          //           snapshot.data;
          //       final String role = documentSnapshot!['role'];
          //       if (role == 'admin') {
          //         return AdminPanel();
          //       } else {
          //         return MainScreen();
          //       }
          //     } else {
          //       return Center(
          //           child: CircularProgressIndicator(
          //         color: AppColors.themeColor,
          //       ));
          //     }
          //   },
          // );
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
