import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  // Observable boolean for password visibility
  var isObscured = true.obs;

  // Toggle the obscured state
  void toggleObscureText() {
    isObscured.value = !isObscured.value;
  }

  void register() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final username = usernameController.text.trim();

    if (password != confirmPassword) {
      Get.snackbar("Gagal", "Password dan Confirm Password tidak cocok!");
      return;
    }

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;

      // Simpan username ke Firestore
      await firestore.collection('users').doc(uid).set({
        'username': username,
        'email': email,
      });

      Get.snackbar("Sukses", "Berhasil Membuat Akun");
      Get.offAllNamed('/login');
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        Get.snackbar("Gagal", "Password terlalu lemah!");
      } else if (e.code == "email-already-in-use") {
        Get.snackbar("Gagal", "Email sudah terdaftar!");
      }
      print(e.code);
    } catch (e) {
      print("Error saat menyimpan username: $e");
      Get.snackbar(
          "Gagal", "Terjadi kesalahan saat menyimpan data. Silakan coba lagi.");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    usernameController.dispose();
    super.onClose();
  }
}
