import 'package:flutter/material.dart';
import 'package:medic_ally/src/constants/text_strings.dart';

class MedicineAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MedicineAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        mMedicines,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
