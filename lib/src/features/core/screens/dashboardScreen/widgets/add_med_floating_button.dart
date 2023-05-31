import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_ally/providers/add_medicine_provider.dart';
import 'package:medic_ally/src/constants/color_schemes.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:provider/provider.dart';

class AddMedFloating extends StatelessWidget {
  const AddMedFloating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;

    final isDarkMode = brightness == Brightness.dark;

    return FloatingActionButton.extended(
      onPressed: () {
        Provider.of<AddMedicineName>(context, listen: false)
            .clearMedicineName();
        Provider.of<AddMedicineStock>(context, listen: false).clearStock();
        Provider.of<SelectedCircleProvider>(context, listen: false)
            .clearContainer();
        Get.toNamed('/addmed');
      },
      label: const Text(mAddmed,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          )),
      icon: const Icon(Icons.add),
      backgroundColor:
          isDarkMode ? darkColorScheme.primary : lightColorScheme.primary,
      foregroundColor: isDarkMode ? Colors.black : Colors.white,
    );
  }
}
