import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/features/authentication/controllers/login_controller.dart';
import '../../forgotPassScreens/forgotPassOptions/forgot_pass_modal.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    final _formKey = GlobalKey<FormState>();

    return Form(
      child: Container(
        key: _formKey,
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: loginController.email,
              decoration: const InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.email_rounded),
                labelText: mEmail,
                hintText: mEnterEmail,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: loginController.password,
              obscureText: true,
              decoration: const InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.lock),
                //suffixIcon: Icon(Icons.visibility),
                labelText: mPassword,
                hintText: mEnterPassword,
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(

              onPressed: () {
                LoginController.instance.loginUser(
                  loginController.email.text.trim(),
                  loginController.password.text.trim(),
                );
                //Get.toNamed('/botnavbar');
              },
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
