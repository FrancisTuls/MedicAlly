import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medic_ally/src/constants/text_strings.dart';

class DashAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DashAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const CircleAvatar(
              radius: 24,
              backgroundColor: Color.fromARGB(255, 85, 147, 254),
              child: Text('AH'),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Hello, User',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                mDashStatusText,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
      automaticallyImplyLeading: false,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(55);
}
