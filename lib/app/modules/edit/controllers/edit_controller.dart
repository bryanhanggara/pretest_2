import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditController extends GetxController {
  late TextEditingController titleController;
  late TextEditingController momentController;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var selectedEmoticon = 'happy'.obs;

  Future<DocumentSnapshot<Object?>> getData(String docID) async {
    DocumentReference docRef = firestore.collection('moments').doc(docID);
    return docRef.get();
  }

  void updateData(
      String docID, String title, String moment, String emoticon) async {
    try {
      await firestore.collection('moments').doc(docID).update({
        'title': title,
        'moment': moment,
        'emoticon': selectedEmoticon.value,
      });

      Get.back();
      Get.snackbar("Sukses", "Momen diperbarui");
    } catch (e) {
      print(e);
      Get.snackbar("Gagal", "Periksa kembali perubahannya");
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
    super.onInit();
  }

  @override
  void onClose() {
    titleController.dispose();
    momentController.dispose();
    super.onClose();
  }
}
