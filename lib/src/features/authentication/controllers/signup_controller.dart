import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_ally/src/features/authentication/models/user_model.dart';
import 'package:medic_ally/src/features/authentication/screens/forgotPassScreens/forgotPassOtp/otp_screen.dart';
import 'package:medic_ally/src/repository/authentication_repository/authentication_repository.dart';
import 'package:medic_ally/src/repository/user_repository/user_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //TextField controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  final userRepo = Get.put(UserRepository());

  Future<void> registerUser(String email, String password) async {
    String? error = await AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
    if (error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString()));
    }
  }

  /*void createUser(UserModel user) async {
    await userRepo.createUser(user);
    phoneAuthentication(user.phoneNo);
    Get.to(() => const OTPScreen());
  }*/

  void createUser(UserModel user) async {
    // Create the user in Firebase Authentication
    await registerUser(user.email, user.password);

    // Get the user ID from Firebase Authentication
    final userId = FirebaseAuth.instance.currentUser!.uid;

    // Create a new document in the "Users" collection in Cloud Firestore
    final userDocRef =
        FirebaseFirestore.instance.collection("Users").doc(userId);
    await userDocRef.set(user.toJson());

    phoneAuthentication(user.phoneNo);
    Get.to(() => const OTPScreen());
  }

  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}
