import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FirestoreController extends GetxController {
  RxBool loader = false.obs;

  Future<Stream<QuerySnapshot>> getData(String collection) async {
    return await FirebaseFirestore.instance.collection(collection).snapshots();
  }
}
