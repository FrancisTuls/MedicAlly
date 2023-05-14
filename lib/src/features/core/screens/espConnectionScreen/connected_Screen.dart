import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:medic_ally/src/constants/image_strings.dart';
import 'package:medic_ally/src/constants/sizes_strings.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/features/core/screens/espConnectionScreen/widgets/setup3_connected_footer.dart';

class ConnectedScreen extends StatelessWidget {
  const ConnectedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed('/signup');
            },
            child: Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.fromLTRB(0, 80, 0, 0),
              child: const Image(
                alignment: Alignment.center,
                image: AssetImage(mSuccessConnection),
                width: 326,
                height: 327,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(35),
            child: Column(
              children: const [
                Text(
                  mConnected,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
              ],
            ),
          ),
          ConnectedFooter(size: size),
        ],
      ),
    );
  }
}
