import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/features/authentication/controllers/login_controller.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _isObscure = true;

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
            TextFormField(
              controller: loginController.email,
              decoration: const InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.email_rounded),
                labelText: mEmail,
                hintText: mEnterEmail,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: loginController.password,
              decoration: InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    }),
                labelText: mPassword,
                hintText: mEnterPassword,
              ),
              obscureText: _isObscure,
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
          ],
        ),
      ),
    );
  }
}
