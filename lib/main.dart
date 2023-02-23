import 'package:flutter/material.dart';
import 'package:medic_ally/src/features/authentication/screens/welcomeScreen/welcome_screen.dart';
import 'package:medic_ally/src/utils/theme/theme.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MedicAppTheme.lightTheme,
      darkTheme: MedicAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const WelcomeScreen(),
    );
  }
}
