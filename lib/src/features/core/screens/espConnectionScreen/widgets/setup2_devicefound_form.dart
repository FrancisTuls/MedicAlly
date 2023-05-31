import 'package:flutter/material.dart';
import 'package:medic_ally/src/constants/text_strings.dart';

class DeviceFoundForm extends StatelessWidget {
  const DeviceFoundForm({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
      padding: const EdgeInsets.symmetric(vertical: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          TextField(
            decoration: InputDecoration(
              filled: true,
              prefixIcon: Icon(Icons.lock_clock_rounded),
              labelText: mIDnumber,
              hintText: mEnterIDnumber,
            ),
          )
        ],
      ),
    ));
  }
}
