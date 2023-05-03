import 'package:flutter/material.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/constants/image_strings.dart';

class SetupDeviceBody extends StatelessWidget {
  const SetupDeviceBody({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                textStyle: const TextStyle(fontSize: 18),
                foregroundColor: Colors.blue,
                side: const BorderSide(
                    width: 1, color: Color.fromARGB(37, 0, 0, 0))),
            label: const Text('Turn on WIFI on this device'),
            icon: const Icon(Icons.wifi),
            onPressed: () {}),
        const Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
        OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                textStyle: const TextStyle(fontSize: 12),
                foregroundColor: Colors.blue,
                side: const BorderSide(
                    width: 1, color: Color.fromARGB(37, 0, 0, 0))),
            label: const Text('Turn on MedicAlly Device on this device'),
            icon: ImageIcon(
              AssetImage(mSetupDeviceIcon),
              size: 18,
            ),
            onPressed: () {}),
      ],
    );
  }
}
