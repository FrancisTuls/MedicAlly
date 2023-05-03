import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/constants/image_strings.dart';

class ConnectedFooter extends StatelessWidget {
  const ConnectedFooter({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final shape = StadiumBorder();
    return Column(
      children: [
        GestureDetector(
          onTap: () => context.goNamed("bottom_navbar"),
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
                'Continue',
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
              foregroundColor: Color.fromARGB(156, 0, 0, 0),
            ),
            child: const Text('Get Help'),
            onPressed: () {}),
      ],
    );
  }
}
