import 'package:flutter/material.dart';
import 'package:medic_ally/src/constants/text_strings.dart';

class AddSchedAppBar extends StatelessWidget with PreferredSizeWidget {
  const AddSchedAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        mAddSchedule,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
            onPressed: () {},
            child: const Text(
              mDone,
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}
