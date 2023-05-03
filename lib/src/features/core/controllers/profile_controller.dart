import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_ally/src/features/authentication/models/user_model.dart';
import 'package:medic_ally/src/repository/authentication_repository/authentication_repository.dart';
import 'package:medic_ally/src/repository/user_repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  //One user data
  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue.");
    }
  }

  //All user data
  Future<List<UserModel>> getAllUser() async {
    return await _userRepo.allUser();
  }

  updateRecord(UserModel user) async {
    await _userRepo.updateUserRecord(user);
  }
}
