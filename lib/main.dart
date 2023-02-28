import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medic_ally/src/features/authentication/screens/loginScreen/login_screen.dart';
import 'package:medic_ally/src/features/authentication/screens/signupScreen/signup_screen.dart';
import 'package:medic_ally/src/features/authentication/screens/welcomeScreen/welcome_screen.dart';
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
  routes: [
    GoRoute(
      path: '/',
      name: "welcome_screen",
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: "/login",
      name: "login_screen",
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: "/signup",
      name: "signup_screen",
      builder: (context, state) => const SignUpScreen(),
    )
  ],
);
