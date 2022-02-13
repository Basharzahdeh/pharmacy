import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:test_proj/utils/storage.dart';
import 'auth_screen/login_page.dart';
import 'home_pages/main_screen.dart';
class splash_Screen extends StatefulWidget {
  const splash_Screen({Key key}) : super(key: key);


  @override
  _splash_ScreenState createState() => _splash_ScreenState();
}

class _splash_ScreenState extends State<splash_Screen> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        body: SplashScreen(
          backgroundColor: Colors.white,
          loaderColor: Colors.grey,
          image: Image.asset('image/logo2.png'),
          photoSize: 175,
          seconds: 3,
          navigateAfterSeconds: Main_Screen() //Storage().getLoginValue() ?  Main_Screen() : LoginPage(),
        ),
      ),
    );
  }
}
