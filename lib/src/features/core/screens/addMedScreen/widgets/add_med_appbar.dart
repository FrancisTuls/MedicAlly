import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_ally/src/constants/text_strings.dart';

class AddMedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AddMedAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        mAddMedicine,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.today),
          onPressed: () {
            Get.toNamed('/addsched');
          },
        ),
      ],
    );
  }
}
