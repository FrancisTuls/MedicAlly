import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        const Text(
          'or continue with',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const FaIcon(FontAwesomeIcons.google),
          label: const Text(mSigninGoogle),
          style:
              OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              mLoginNoAccount,
            ),
            TextButton(
              onPressed: () => context.goNamed("signup_screen"),
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
