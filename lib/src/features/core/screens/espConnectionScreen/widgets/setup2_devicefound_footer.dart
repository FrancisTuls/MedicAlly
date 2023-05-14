import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/constants/image_strings.dart';

class DeviceFoundFooter extends StatelessWidget {
  const DeviceFoundFooter({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed('/success_connection');
          },
          child: Container(
            height: 50,
            width: 350,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.cyan, Colors.blue],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Center(
              child: Text(
                mSubmit,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
            style: TextButton.styleFrom(
              textStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            child: const Text(mGetHelp),
            onPressed: () {}),
      ],
    );
  }
}
