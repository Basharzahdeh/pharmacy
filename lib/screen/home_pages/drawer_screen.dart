import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:test_proj/controller/auth_controller.dart';
import 'package:test_proj/screen/auth_screen/login_page.dart';
import 'package:url_launcher/url_launcher.dart';

class Drawer_screen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    void whatsappr() async {
      var whatsapp = "+962780156624";
      var whatsappURl_android =
          "whatsapp://send?phone=" + whatsapp + "&text=مرحبا";
      var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
      if (Platform.isIOS) {
        // for iOS phone only
        if (await canLaunch(whatappURL_ios)) {
          await launch(whatappURL_ios, forceSafariVC: false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("whatsapp no installed")));
        }
      } else {
        if (await canLaunch(whatsappURl_android)) {
          await launch(whatsappURl_android);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("whatsapp no installed")));
        }
      }
    }
    return Drawer(
      backgroundColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 50, 0, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
                onPressed: whatsappr,
                child: Row(
                  children: const [
                    Text(
                      'To communicate',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.call,color: Colors.green,),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: ()  {
                  showDialog<void>(
                  context: context,
                  builder: (innerContext) => AlertDialog(
                    title: const Text("About Us!"),
                    content: const Text(
                        'We are an online pharmacy to meet your needs of medicines and other products. \n'
                            'We wish you a pleasant shopping'),
                    actions:<Widget> [
                      ElevatedButton(
                        child:  const Text("Ok"),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ));
                },
                child: Row(
                  children: const [
                    Text(
                      'About Us',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.info,color: Colors.green,),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            TextButton(

                onPressed: () async {
                  await authController.signOut()
                      ? Get.offAll(LoginPage())
                      : Get.snackbar('Wait!!', authController.errorText.value);
                },
                child: Row(
                  children: const [
                     Text(
                      'Log Out',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.arrow_forward_ios,color: Colors.green,),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
