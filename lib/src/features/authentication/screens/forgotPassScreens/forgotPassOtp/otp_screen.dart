import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:medic_ally/src/constants/image_strings.dart';
import 'package:medic_ally/src/constants/text_strings.dart';
import 'package:medic_ally/src/features/authentication/controllers/otp_controller.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var otpController = Get.put(OTPController());
    var otp;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          mOTPTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: const AssetImage(mOtpScreen),
                height: size.height * 0.25,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "$mOTPTSubtitle medicAlly@gmail.com",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 30,
              ),
              OtpTextField(
                numberOfFields: 6,
                fieldWidth: 45,
                focusedBorderColor: const Color.fromARGB(255, 24, 117, 203),
                showFieldAsBox: true,
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                onSubmit: (code) {
                  otp = code;
                  OTPController.instance.verifyOTP(otp);
                },
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                borderWidth: 4,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    OTPController.instance.verifyOTP(otp);
                  },
                  style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                  child: const Text(mNext),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
