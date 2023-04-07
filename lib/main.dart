import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medic_ally/src/features/authentication/screens/forgotPassScreens/forgotPassMail/forgot_pass_mail.dart';
import 'package:medic_ally/src/features/authentication/screens/forgotPassScreens/forgotPassOtp/otp_screen.dart';
import 'package:medic_ally/src/features/authentication/screens/loginScreen/login_screen.dart';
import 'package:medic_ally/src/features/authentication/screens/signupScreen/signup_screen.dart';
import 'package:medic_ally/src/features/authentication/screens/welcomeScreen/welcome_screen.dart';
import 'package:medic_ally/src/features/core/screens/dashboard/dashboard.dart';
import 'package:medic_ally/src/features/core/screens/dashboard/widgets/bottom_navbar.dart';
import 'package:medic_ally/src/utils/theme/theme.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: MedicAppTheme.lightTheme,
      darkTheme: MedicAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: _router,
      title: "MedicAlly",
    );
  }
}

final _router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: "welcome_screen",
      builder: (context, state) => const WelcomeScreen(),
      routes: [
        GoRoute(
          path: "login",
          name: "login_screen",
          builder: (context, state) => const LoginScreen(),
          routes: [
            GoRoute(
              path: "forgotpassmail",
              name: "forgot_pass_mail_screen",
              builder: (context, state) => const ForgetPassMailScreen(),
              routes: [
                GoRoute(
                  path: "OTPScreen",
                  name: "OTP_screen",
                  builder: (context, state) => const OTPScreen(),
                )
              ],
            ),
          ],
        ),
        GoRoute(
          path: "signup",
          name: "signup_screen",
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: "bottomnavbar",
          name: "bottom_navbar",
          builder: (context, state) => const BottomNavbar(),
        ),
      ],
    ),
  ],
);
