import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medic_ally/src/constants/image_strings.dart';
import 'package:medic_ally/src/constants/text_strings.dart';

class ForgetPassMailScreen extends StatelessWidget {
  const ForgetPassMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          mForgotPass,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Image(
                image: const AssetImage(mForgotPassEmailImage),
                height: size.height * 0.25,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                mResetEmailDescription,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                child: Column(
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: Icon(Icons.email_rounded),
                        labelText: mEmail,
                        hintText: mEnterEmail,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => context.pushNamed("OTP_screen"),
                        style: FilledButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        child: const Text(mNext),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
