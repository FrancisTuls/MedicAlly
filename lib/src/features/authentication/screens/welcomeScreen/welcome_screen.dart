import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medic_ally/src/constants/color_schemes.dart';
import 'package:medic_ally/src/constants/image_strings.dart';
import 'package:medic_ally/src/constants/text_strings.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;

    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Container(
              height: 350,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(mWelcomeScreen), fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            top: 295,
            child: Container(
              width: 500,
              height: 800,
              decoration: BoxDecoration(
                  gradient: isDarkMode ? mGradientDark : mGradientLight,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: Container(
                margin: const EdgeInsets.all(30),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Text(
                      mWelcomeTitle,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      mWelcomeSubtitle,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 74,
                    ),
                    ElevatedButton(
                      onPressed: () => context.goNamed("signup_screen"),
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        minimumSize: const Size.fromHeight(50),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      child: const Text(mGetStarted),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          mHaveAcc,
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                        TextButton(
                          onPressed: () => context.goNamed("login_screen"),
                          child: const Text(
                            mLogin,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 140,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          mTerms,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
