import 'package:flutter/material.dart';
import 'package:medic_ally/src/constants/sizes_strings.dart';
import 'package:medic_ally/src/features/authentication/screens/loginScreen/widgets/login_form_widget.dart';
import 'package:medic_ally/src/features/authentication/screens/loginScreen/widgets/login_header_widget.dart';
import 'package:medic_ally/src/features/authentication/screens/loginScreen/widgets/login_footer_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(mDefaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LoginHeader(size: size),
              const LoginForm(),
              const LoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
