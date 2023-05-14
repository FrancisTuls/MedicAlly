import 'package:flutter/material.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/constants/image_strings.dart';

class SetupDeviceHeader extends StatelessWidget {
  const SetupDeviceHeader({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: const AssetImage(mSetupDevice1),
          height: size.height * 0.20,
        ),
        const Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
        const Text(
          mStep1,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        const Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
        const Text(
          mStep1_1,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
