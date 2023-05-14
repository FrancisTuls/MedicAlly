import 'package:get/get.dart';
import 'package:medic_ally/src/features/core/controllers/network_controller.dart';

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
