import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  // Observable boolean for password visibility
  var isObscured = true.obs;

  // Toggle the obscured state
  void toggleObscureText() {
    isObscured.value = !isObscured.value;
  }

  Stream<User?> get streamAuthStatus =>
      FirebaseAuth.instance.authStateChanges();

  void login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        print("email tidak cocok");
        Get.snackbar(
          "Ups!",
          "Email Tidak Ditemukan",
        );
      } else if (e.code == "invalid-email") {
        Get.snackbar("Cek Lagi", "Email tidak valid!");
      } else if (e.code == 'wrong-password') {
        print("password tidak cocok");
        Get.snackbar(
          "Ups!",
          "Password Salah",
        );
      } else if (e.code == 'too-many-request') {
        print("terlalu banyak mencoba");
        Get.snackbar(
          "Sudah dulu ya!",
          "Terlalu banyak mencoba, ingat ingat lagi!",
        );
      }
      print(e.code);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
