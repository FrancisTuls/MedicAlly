import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_ally/src/features/authentication/controllers/signup_controller.dart';
import 'package:medic_ally/src/features/authentication/models/user_model.dart';
import 'package:medic_ally/src/repository/authentication_repository/authentication_repository.dart';
import '../../../../../constants/text_strings.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    var authRepository = Get.put(AuthenticationRepository());
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.fullName,
              decoration: const InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.person),
                labelText: mFullName,
                hintText: mEnterFullName,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.mail),
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
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.phoneNo,
              decoration: const InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.call),
                labelText: mPhone,
                hintText: mEnterPhone,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: controller.password,
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              obscureText: _isObscure,
            ),
            const SizedBox(
              height: 20,
            ),
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  //For Email and Password
                  /*SignUpController.instance.registerUser(
                      controller.email.text.trim(),
                      controller.password.text.trim());*/

                  //For Phone
                  /*SignUpController.instance
                      .phoneAuthentication(controller.phoneNo.text.trim());
                  Get.toNamed('/OTPScreen');*/

                  //For Phone OTPScreen
                  //SignUpController.instance.createUser(user);

                  final user = UserModel(
                    email: controller.email.text.trim(),
                    password: controller.password.text.trim(),
                    fullName: controller.fullName.text.trim(),
                    phoneNo: controller.phoneNo.text.trim(),
                  );

                  SignUpController.instance.createUser(user);

                  /*SignUpController.instance.registerUser(
                      controller.email.text.trim(),
                      controller.password.text.trim());*/
                }
              },
              style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold)),
              child: const Text(mSignUp),
            ),
          ],
        ),
      ),
    );
  }
}
