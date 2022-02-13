import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_proj/screen/home_pages/main_screen.dart';

import '../../../controller/auth_controller.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Scaffold(
      body: Center(
          child: Text(
              'Please Verify email at\n ${authController.emailController.value.text}',
              style: const TextStyle(
                fontSize: 30.0,
              ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 100.0),
        child: FlatButton(
          color: Colors.lightGreen,
          onPressed: () async {
            await authController.verifyUser();
            if (authController.isVerified.value) {
              Get.offAll(Main_Screen());
            }
          },
          child:authController.isVerified.value? const Text('Done'):const Text('Wait')
        ),
      ),
    );
  }
}
