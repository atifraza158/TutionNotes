import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Utils/Components/subject_card.dart';
import 'Utils/app_colors/app_colors.dart';

// ignore: must_be_immutable
class SubjectCardData extends StatelessWidget {
  SubjectCardData({
    super.key,
    this.index1,
    this.index2,
  });
  final int? index1;
  final int? index2;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Subjects').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              2,
              (index) {
                DocumentSnapshot subjects = snapshot.data!.docs[index];
                return SubjectCard(
                  title: subjects['subject_name'],
                  imagePath: subjects['image'],
                  onPressed: () {},
                  cardColor: colors[index],
                );
              },
            ),
          );
          // GridView.builder(
          //   physics: NeverScrollableScrollPhysics(),
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //   ),
          //   itemCount: 4,
          //   itemBuilder: (context, index) {
          //     DocumentSnapshot subjects = snapshot.data!.docs[index];
          //     return Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: SubjectCard(
          //         title: subjects['subject_name'],
          //         imagePath: subjects['image'],
          //         onPressed: () {},
          //         cardColor: colors[index],
          //       ),
          //     );
          //   },
          // );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primary_color,
            ),
          );
        }
      },
    );
  }

  List colors = [
    AppColors.grey,
    Colors.lightGreen,
    AppColors.linear_gradient1,
    AppColors.linear_gradient2,
  ];
}
