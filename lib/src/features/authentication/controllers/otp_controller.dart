import 'package:get/get.dart';
import 'package:medic_ally/src/features/core/screens/dashboardScreen/widgets/bottom_navbar.dart';
import 'package:medic_ally/src/repository/authentication_repository/authentication_repository.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const BottomNavbar()) : Get.back();
  }
}
