import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_ally/src/constants/text_strings.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              mLoginNoAccount,
            ),
            TextButton(
              onPressed: () {
                Get.offNamed('/signup');
              },
              child: const Text(
                mSignUp,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ],
    );
  }
}
