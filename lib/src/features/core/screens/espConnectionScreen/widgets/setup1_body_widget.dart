import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/constants/image_strings.dart';
import 'package:permission_handler/permission_handler.dart';

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
          onPressed: () {},
          icon: const Icon(Icons.wifi_rounded),
          label: const Text(mTurnOnWifi),
          style:
              OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
        ),
        const Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Symbols.oven_gen_rounded),
          label: const Text(mTurnOnDispenser),
          style:
              OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
        ),
      ],
    );
  }
}
