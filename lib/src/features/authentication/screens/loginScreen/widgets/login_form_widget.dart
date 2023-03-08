import 'package:flutter/material.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import '../../forgotPassScreens/forgotPassOptions/forgot_pass_modal.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextField(
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.email_rounded),
                labelText: mEmail,
                hintText: mEnterEmail,
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.visibility),
                labelText: mPassword,
                hintText: mEnterPassword,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold)),
              child: const Text(mLogin),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  mForgotPassword,
                ),
                TextButton(
                  onPressed: () {
                    ForgotPassModal.showModalForgotPass(context);
                  },
                  child: const Text(
                    mReset,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
