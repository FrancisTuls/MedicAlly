import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../../constants/text_strings.dart';
import 'forgot_pass_button_widget.dart';

class ForgotPassModal {
  static Future<dynamic> showModalForgotPass(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              mForgotPassTitle,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const Text(
              mForgotPassSubtitle,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
            ),
            const SizedBox(height: 30),
            ForgetPassButton(
                buttonIcon: Icons.mail,
                title: mEmail,
                subtitle: mResetEmailSubtitle,
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed("forgot_pass_mail_screen");
                }),
            const SizedBox(height: 20),
            ForgetPassButton(
                buttonIcon: Icons.smartphone,
                title: mPhoneNum,
                subtitle: mResetOTPSubtitle,
                onTap: () {}),
          ],
        ),
      ),
    );
  }
}
