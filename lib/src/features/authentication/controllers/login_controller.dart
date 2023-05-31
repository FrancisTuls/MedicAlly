import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_ally/src/constants/color_schemes.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/repository/authentication_repository/authentication_repository.dart';
import 'package:medic_ally/src/repository/user_repository/user_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();

  /// TextField Validation

  //Call this Function from Design & it will do the rest
  void loginUser(String email, String password) async {
    String? error = await AuthenticationRepository.instance
        .loginWithEmailAndPassword(email, password);

    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    } else {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      final user = await UserRepository.instance.getUserDetails(userId!);

      Get.snackbar(
        mLoginTitle,
        "Welcome Back, $user.fullName!",
        colorText: Colors.black,
        backgroundColor: lightColorScheme.tertiaryContainer,
        icon: const Icon(Icons.waving_hand_rounded),
      );
    }
  }
}
