// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:tution_notes/Views/Utils/app_colors/app_colors.dart';
// import 'package:tution_notes/Views/Utils/app_text/app_text.dart';

// class MathNotes extends StatefulWidget {
//   const MathNotes({super.key});

//   @override
//   State<MathNotes> createState() => _MathNotesState();
// }

// class _MathNotesState extends State<MathNotes> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: AppText(
//           title: 'Mathematics',
//         ),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('Subjects')
//             .where('subject_name', isEqualTo: 'Math')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             // return ;
//           } else {
//             return Center(
//               child: CircularProgressIndicator(
//                 color: AppColors.primary_color,
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
