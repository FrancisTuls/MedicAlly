import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_ally/src/constants/text_strings.dart';

class AddMedFloating extends StatelessWidget {
  const AddMedFloating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Get.toNamed('/addmed');
      },
      label: const Text(mAddmed),
      icon: const Icon(Icons.add),
    );
  }
}
