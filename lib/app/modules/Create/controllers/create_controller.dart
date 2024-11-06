import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController momentController;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  var selectedEmoticon = 'happy'.obs;
  String? username;

  Future<void> _fetchUsername() async {
    String userId = auth.currentUser?.uid ?? "unknown";
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(userId).get();

    if (userDoc.exists) {
      username = userDoc['username'];
    } else {
      username = "Unknown";
    }
  }

  void addData(
    String title,
    String moment,
  ) async {
    try {
      String dateNow = DateTime.now().toString();

      await firestore.collection('moments').add({
        'title': title,
        'moment': moment,
        'createdBy': username,
        'emoticon': selectedEmoticon.value,
        'timestamp': dateNow,
      });
      Get.back();
      Get.snackbar("Sukses", "Momen Berhasil Ditambah");
      titleController.clear();

      momentController.clear();
    } catch (e) {
      print(e);
    }
  }

  void setEmoticon(String emoticon) {
    selectedEmoticon.value = emoticon;
    update();
  }

  @override
  void onInit() {
    titleController = TextEditingController();
    momentController = TextEditingController();
    _fetchUsername();
    super.onInit();
  }

  @override
  void onClose() {
    titleController.dispose();

    momentController.dispose();
    super.onClose();
  }
}
