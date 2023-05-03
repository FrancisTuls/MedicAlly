import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:medic_ally/providers/add_medicine_provider.dart';
import 'package:medic_ally/src/features/authentication/controllers/otp_controller.dart';
import 'package:medic_ally/src/features/authentication/controllers/signup_controller.dart';
import 'package:medic_ally/src/features/authentication/screens/forgotPassScreens/forgotPassMail/forgot_pass_mail.dart';
import 'package:medic_ally/src/features/authentication/screens/forgotPassScreens/forgotPassOtp/otp_screen.dart';
import 'package:medic_ally/src/features/authentication/screens/loginScreen/login_screen.dart';
import 'package:medic_ally/src/features/authentication/screens/signupScreen/signup_screen.dart';
import 'package:medic_ally/src/features/authentication/screens/welcomeScreen/welcome_screen.dart';
import 'package:medic_ally/src/features/core/screens/addMedScreen/add_med_screen.dart';
import 'package:medic_ally/src/features/core/screens/addSchedScreen/add_sched_screen.dart';
import 'package:medic_ally/src/features/core/screens/dashboardScreen/dashboard_screen.dart';
import 'package:medic_ally/src/features/core/screens/dashboardScreen/widgets/bottom_navbar.dart';
import 'package:medic_ally/src/features/core/screens/profile/profile_screen.dart';
import 'package:medic_ally/src/features/core/screens/profile/update_profile_screen.dart';
import 'package:medic_ally/src/repository/authentication_repository/authentication_repository.dart';
import 'package:medic_ally/src/utils/theme/theme.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() {
  //Get.put(AuthenticationRepository());
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AddMedicineName()),
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: MedicAppTheme.lightTheme,
      darkTheme: MedicAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      title: "MedicAlly",
      home: const CircularProgressIndicator(
        value: null,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const WelcomeScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(
            name: '/forgotpassmail', page: () => const ForgetPassMailScreen()),
        GetPage(name: '/OTPScreen', page: () => const OTPScreen()),
        GetPage(name: '/signup', page: () => const SignUpScreen()),
        GetPage(name: '/botnavbar', page: () => const BottomNavbar()),
        GetPage(name: '/dashboard', page: () => const Dashboard()),
        GetPage(name: '/addmed', page: () => const AddMedicine()),
        GetPage(name: '/addsched', page: () => const AddSched()),
        GetPage(name: '/profile', page: () => const ProfileScreen()),
        GetPage(
            name: '/update_profile', page: () => const UpdateProfileScreen()),
      ],
    );
  }
}

/*final _router = GoRouter(
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
          routes: [
            GoRoute(
              path: "dashboard",
              name: "dashboard_screen",
              builder: (context, state) => const Dashboard(),
              routes: [
                GoRoute(
                  path: "addmedicine",
                  name: "add_medicine_screen",
                  builder: (context, state) => const AddMedicine(),
                )
              ],
            ),
            GoRoute(
              path: "addschedule",
              name: "add_schedule_screen",
              builder: (context, state) => const AddSched(),
            ),
          ],
        ),
      ],
    ),
  ],
);*/
