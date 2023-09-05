import 'dart:async';

import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:test_proj/utils/storage.dart';
import 'auth_screen/login_page.dart';
import 'home_pages/main_screen.dart';
class splash_Screen extends StatefulWidget {


  @override
  _splash_ScreenState createState() => _splash_ScreenState();
}

class _splash_ScreenState extends State<splash_Screen> {
  checkUserLogin() async {
    Timer(
      const Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) =>Main_Screen()),


      ),
    );

  }
  @override
  Widget build(BuildContext context) {
    return   EasySplashScreen(
        backgroundColor: Colors.white,
        loaderColor: Colors.grey,
        durationInSeconds: 3,
         logo: Image.asset('image/logo2.png',width: 175,),




    );


  }
}
