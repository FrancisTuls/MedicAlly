import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:medic_ally/src/constants/image_strings.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/repository/authentication_repository/authentication_repository.dart';

class DashAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DashAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //var authRepository = Get.put(AuthenticationRepository());
    return AppBar(
      title: Row(
        children: [
          IconButton(
            onPressed: () {
              //AuthenticationRepository.instance.logout();
              Get.toNamed('/profile');
            },
            icon: const CircleAvatar(
              radius: 24,
              backgroundColor: Color.fromARGB(255, 85, 147, 254),
              foregroundImage: AssetImage(mUserProfile),
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
