import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/app/modules/Login/views/login_view.dart';

class HomeController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getMoments() {
    return firestore.collection('moments').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data() as Map<String, dynamic>,
        };
      }).toList();
    });
  }

  void logout() async {
    await auth.signOut();
    Get.off(() => LoginView());
  }

  Future<void> deleteMoment(String docId) async {
    try {
      await firestore.collection('moments').doc(docId).delete();
      Get.snackbar("Sukses", "Momen berhasil dihapus.");
    } catch (e) {
      print("Error deleting moment: $e");
      Get.snackbar("Gagal", "Tidak bisa menghapus momen.");
    }
  }

}
