import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_proj/screen/home_pages/main_screen.dart';

import 'controller/cart_control.dart';
import 'screen/p_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  await GetStorage.init();
  bool? dec = prefs.getBool('x');
  Widget screen = (dec == false || dec == null) ?  PView() : MyApp();
  runApp(screen);
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLod = false;

  @override
  void initState() {
    super.initState();
    Get.put(Cart_Control()).fetchData().then((_) {
      setState(() {
        isLod = true;
      });
    }).catchError((onError) => print(onError));
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pharmacy',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: Main_Screen(),
    );
  }
}
