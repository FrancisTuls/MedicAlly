import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_ally/src/constants/image_strings.dart';
import 'package:medic_ally/src/constants/text_strings.dart';

class DashAppbar extends StatefulWidget implements PreferredSizeWidget {
  const DashAppbar({
    super.key,
  });

  @override
  State<DashAppbar> createState() => _DashAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(55);
}

class _DashAppbarState extends State<DashAppbar> {
  late String _fullName = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot<Map<String, dynamic>> userDoc =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(user.uid)
              .get();
      setState(() {
        _fullName = userDoc['FullName'];
      });
    }
  }

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
            children: [
              Text(
                'Hello, $_fullName',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Text(
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
}
