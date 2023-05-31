import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:app_settings/app_settings.dart';

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
          onPressed: () {
            AppSettings.openWIFISettings();
          },
          icon: const Icon(Icons.wifi_rounded),
          label: const Text(mTurnOnWifi),
          style:
              OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(60)),
        ),
        const SizedBox(height: 20),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Symbols.oven_gen_rounded),
          label: const Text(mTurnOnDispenser),
          style:
              OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(60)),
        ),
      ],
    );
  }
}
