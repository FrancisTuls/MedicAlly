import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medic_ally/src/constants/color_schemes.dart';
import 'package:medic_ally/src/constants/image_strings.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/features/authentication/models/user_model.dart';
import 'package:medic_ally/src/features/core/controllers/profile_controller.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

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
            mEditProfile,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder(
              future: controller.getUserData(),
              //future: controller.getAllUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel user = snapshot.data as UserModel;

                    //Controllers
                    final id = TextEditingController(text: user.id);
                    final email = TextEditingController(text: user.email);
                    final password = TextEditingController(text: user.password);
                    final fullName = TextEditingController(text: user.fullName);
                    final phoneNo = TextEditingController(text: user.phoneNo);

                    return Column(children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: const Image(
                                    image: AssetImage(mUserProfile))),
                          ),
                          /*Positioned(
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
                                Icons.photo_camera_outlined,
                                color: isDarkMode
                                    ? lightColorScheme.primary
                                    : darkColorScheme.primary,
                                size: 20,
                              ),
                            ),
                          )*/
                        ],
                      ),
                      const SizedBox(height: 50),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: fullName,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                filled: false,
                                prefixIcon: Icon(Icons.person),
                                labelText: mFullName,
                                hintText: mEnterFullName,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: email,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                filled: false,
                                prefixIcon: Icon(Icons.mail),
                                labelText: mEmail,
                                hintText: mEnterEmail,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: phoneNo,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                filled: false,
                                prefixIcon: Icon(Icons.call),
                                labelText: mPhone,
                                hintText: mEnterPhone,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: password,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                filled: false,
                                prefixIcon: Icon(Icons.lock),
                                labelText: mPassword,
                                hintText: mEnterPassword,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: () async {
                                  final userData = UserModel(
                                    id: id.text,
                                    email: email.text.trim(),
                                    password: password.text.trim(),
                                    fullName: fullName.text.trim(),
                                    phoneNo: phoneNo.text.trim(),
                                  );

                                  await controller.updateRecord(userData);
                                },
                                style: FilledButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                child: const Text("Save"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]);
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
        ));
  }
}
