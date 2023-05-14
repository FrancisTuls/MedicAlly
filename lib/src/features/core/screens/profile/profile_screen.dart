import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_ally/src/constants/color_schemes.dart';
import 'package:medic_ally/src/constants/image_strings.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/features/authentication/models/user_model.dart';
import 'package:medic_ally/src/features/core/controllers/profile_controller.dart';
import 'package:medic_ally/src/features/core/screens/profile/widgets/profile_menu_widget.dart';
import 'package:medic_ally/src/repository/authentication_repository/authentication_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;

    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          mProfile,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel user = snapshot.data as UserModel;

                  return Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image(
                                  image: const AssetImage(mUserProfile),
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const CircularProgressIndicator();
                                  },
                                )),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: isDarkMode
                                      ? darkColorScheme.secondary.withOpacity(1)
                                      : lightColorScheme.secondary
                                          .withOpacity(1)),
                              child: Icon(
                                Icons.edit_outlined,
                                color: isDarkMode
                                    ? lightColorScheme.primary
                                    : darkColorScheme.primary,
                                size: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user.fullName,
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        user.email,
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        child: FilledButton(
                          onPressed: () {
                            Get.toNamed('/update_profile');
                          },
                          style: FilledButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              textStyle:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          child: const Text(mEditProfile),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Divider(),
                      const SizedBox(height: 10),

                      //Menus
                      /*ProfileMenuWidget(
                          isDarkMode: isDarkMode,
                          icon: Icons.settings_outlined,
                          title: mMenu1,
                          onPress: () {}),
                      ProfileMenuWidget(
                          isDarkMode: isDarkMode,
                          icon: Icons.info_outline_rounded,
                          title: mMenu2,
                          onPress: () {}),
                      const Divider(),
                      const SizedBox(height: 10),
                      ProfileMenuWidget(
                          isDarkMode: isDarkMode,
                          icon: Icons.account_circle_outlined,
                          title: mMenu3,
                          onPress: () {}),*/
                      ProfileMenuWidget(
                          isDarkMode: isDarkMode,
                          icon: Icons.logout_outlined,
                          textColor: darkColorScheme.errorContainer,
                          title: mMenu4,
                          endIcon: false,
                          onPress: () {
                            AuthenticationRepository.instance.logout();
                          }),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text('Something went wrong.'));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
