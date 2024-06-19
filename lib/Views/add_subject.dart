import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:tution_notes/Controllers/firestore_controller.dart';
import 'package:tution_notes/Views/Utils/Components/pick_image_widget.dart';
import 'package:tution_notes/Views/Utils/app_colors/app_colors.dart';
import 'package:tution_notes/Views/Utils/app_text/app_text.dart';
import 'package:tution_notes/Views/Utils/common_button.dart';
import 'package:tution_notes/Views/Utils/common_field.dart';
import 'package:tution_notes/Views/all_subjects_screen.dart';

// ignore: must_be_immutable
class AddSubject extends StatefulWidget {
  AddSubject({super.key});

  @override
  State<AddSubject> createState() => _AddSubjectState();
}

class _AddSubjectState extends State<AddSubject> {
  final subjectController = TextEditingController();
  File? image;
  String imageUrlFireStore = '';
  final key = GlobalKey<FormState>();

  FirestoreController firestoreController = Get.put(FirestoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AppText(
                    title: 'Add a New Subject',
                    size: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                PickImageWidget(
                  onPressed: () {
                    getImage();
                  },
                  image: image,
                ),
                SizedBox(height: 15),
                CommonTextField(
                  hintText: 'Subject Name',
                  controller: subjectController,
                  validate: (val) {
                    if (val == null) {
                      return 'Field cannot be empty';
                    } else {
                      return null;
                    }
                  },
                  obsecureText: false,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: CommonButton(
          child: Obx(
            () => firestoreController.loader.value
                ? CircularProgressIndicator(
                    color: AppColors.white,
                  )
                : AppText(
                    title: 'Add Subject',
                    color: AppColors.white,
                    size: 16,
                  ),
          ),
          onPressed: () async {
            // Create unique file name with time stamp
            String UniqueFileName =
                DateTime.now().millisecondsSinceEpoch.toString();
            // Creating instance of Firebase Cloud
            Reference referenceRoot = FirebaseStorage.instance.ref();
            // Creating here images folder inside the Firebase Cloud
            Reference referenceDirImages = referenceRoot.child('ItemImages');

            // Passing the name to the uploaded image
            Reference referenceImageToUpload =
                referenceDirImages.child(UniqueFileName);

            try {
              // Uploading the image to Firebase Cloud, with path
              await referenceImageToUpload.putFile(File(image!.path));
              imageUrlFireStore = await referenceImageToUpload.getDownloadURL();
            } catch (e) {
              //  Handle Errors here..
            }
            String id = randomAlphaNumeric(8);
            Map<String, dynamic> subjectData = {
              'id': id,
              'subject_name': subjectController.text.toString(),
              'created_at': Timestamp.now(),
              'image': imageUrlFireStore,
            };
            firestoreController.addData(subjectData, id, 'Subjects').then((_) {
              Get.snackbar("Success", 'New Subject Added');
              Get.off(() => AllSubjectsScreen());
            });
          },
        ),
      ),
    );
  }

  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File tempImage = File(pickedFile.path);

      int fileSize = await tempImage.length();
      if (fileSize <= 2 * 1024 * 1024) {
        image = tempImage;
        debugPrint("Image path: ${image!.path}");
        setState(() {});
      } else {
        Get.snackbar(
          'Warning',
          "The selected image is too large. Please choose an image smaller than 2MB.",
        );
      }
    }
  }
}
