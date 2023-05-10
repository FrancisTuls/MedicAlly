import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medic_ally/src/constants/image_strings.dart';
import 'package:medic_ally/src/constants/sizes_strings.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/features/core/screens/espConnectionScreen/widgets/setup2_devicefound_footer.dart';
import 'package:medic_ally/src/features/core/screens/espConnectionScreen/widgets/setup2_devicefound_form.dart';

class DeviceFound extends StatelessWidget {
  const DeviceFound({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            alignment: Alignment.topCenter,
            child: const Image(
              alignment: Alignment.center,
              image: AssetImage(mSetupDeviceSearching),
              width: 250,
              height: 250,
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.all(35),
            child: Column(
              children: const [
                Text(
                  mDeviceFound1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Text(
                  mDeviceFound1_1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
                DeviceFoundForm(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(30),
            alignment: Alignment.center,
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [DeviceFoundFooter(size: size)],
            )),
          )
        ],
      ),
    ));
  }
}
