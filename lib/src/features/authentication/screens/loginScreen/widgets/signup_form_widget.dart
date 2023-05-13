import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_ally/src/features/authentication/controllers/signup_controller.dart';
import 'package:medic_ally/src/features/authentication/models/user_model.dart';
import 'package:medic_ally/src/features/authentication/screens/forgotPassScreens/forgotPassOtp/otp_screen.dart';
import 'package:medic_ally/src/repository/authentication_repository/authentication_repository.dart';
import '../../../../../constants/text_strings.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

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
            TextField(
              controller: controller.fullName,
              decoration: const InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.person),
                labelText: mFullName,
                hintText: mEnterFullName,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller.email,
              decoration: const InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.mail),
                labelText: mEmail,
                hintText: mEnterEmail,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller.phoneNo,
              decoration: const InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.call),
                labelText: mPhone,
                hintText: mEnterPhone,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller.password,
              decoration: const InputDecoration(
                filled: true,
                prefixIcon: Icon(Icons.lock),
                labelText: mPassword,
                hintText: mEnterPassword,
              ),
              obscureText: true,
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
