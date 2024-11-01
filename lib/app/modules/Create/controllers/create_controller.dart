import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController nameController;
  late TextEditingController momentController;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void addData(
    String title,
    String name,
    String moment,
  ) async {
    try {
      String dateNow = DateTime.now().toString();
      await firestore.collection('moments').add({
        'title': title,
        'name': name,
        'moment': moment,
      });
      Get.back();
      Get.snackbar("Sukses", "Momen Berhasil Ditambah");
      titleController.clear();
      nameController.clear();
      momentController.clear();
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    titleController = TextEditingController();
    nameController = TextEditingController();
    momentController = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    titleController.dispose();
    nameController.dispose();
    momentController.dispose();
    super.onClose();
  }
}
