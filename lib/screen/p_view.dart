import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_proj/controller/auth_controller.dart';
import 'auth_screen/login_page.dart';
import 'home_pages/main_screen.dart';
import 'splash_screen.dart';
class Data {
  final  logo;
  final  imageUrl;
  final  descraption1;
  final  descraption2;

  Data({
    @required this.logo,
    @required this.imageUrl,
    @required this.descraption1,
    @required this.descraption2,
  });
}

class PView extends StatefulWidget {

  @override
  _PViewState createState() => _PViewState();
}

class _PViewState extends State<PView> {
  final AuthController authController = Get.put(AuthController());

  final List<Data> myData = [
    Data(
      logo: 'image/logo2.png',
      imageUrl: 'image/ph1.png',
      descraption1: 'Order Medicine Online',
      descraption2: 'Authenticity 100% Guaranteed'
    ),
    Data(
      logo: 'image/logo2.png',
      imageUrl: 'image/ph2.png',
      descraption1: 'Consult Doctors',
      descraption2: 'Connect a Doctor Anytime'
    ),
    Data(
      logo: 'image/logo2.png',
      imageUrl: 'image/ph3.png',
      descraption1: 'Free Delivery',
      descraption2: 'Same Day Delivery'
    ),
  ];

  int currantIndex = 0;
  final PageController controller = PageController(
    initialPage: 0,
  );
  final pageIndexNotifier = ValueNotifier<int>(0);

  @override
  void initState()  {
    Timer.periodic(const Duration(seconds: 7), (timer) {
     /* if (currantIndex < 3) currantIndex++;
      controller.animateToPage(currantIndex,
          duration: const Duration(seconds: 2), curve: Curves.easeIn);*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/a': (ctx) => Main_Screen(),
        '/b': (ctx) =>  splash_Screen(),
      },
      home: Scaffold(
        body: Stack(
          alignment: const Alignment(0,0.7),
          children: [
            Builder(
              builder: (ctx) => PageView(
                controller: controller,
                onPageChanged: (val) {
                  pageIndexNotifier.value=val;
                  setState(() {
                    currantIndex = val;
                    /*if (currantIndex == 3) {
                      Future.delayed(Duration(seconds: 2),
                          () => Navigator.of(ctx).pushNamed('/b'));
                    }*/
                  });
                },
                children: myData
                    .map((item) => Container(
                          decoration: const BoxDecoration(
                            color: Colors.white
                           ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Image.asset(item.logo,width: 200,),
                              const SizedBox(
                                height: 40,
                              ),
                              Image.asset(item.imageUrl),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                item.descraption1,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                item.descraption2,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            //Ind9cator(currantIndex),
            // PageViewIndicator(
            //   pageIndexNotifier: pageIndexNotifier,
            //   length: myData.length,
            //   normalBuilder: (animationController, index) => Container(
            //     height: 8, // Adjust the height as needed
            //     width: 8,  // Adjust the width as needed
            //     margin: const EdgeInsets.all(4),
            //     decoration: BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: Colors.black54,
            //     ),
            //   ),
            //   highlightedBuilder: (animationController, index) =>
            //       ScaleTransition(
            //         scale: CurvedAnimation(
            //           parent: animationController,
            //           curve: Curves.ease,
            //         ),
            //         child: Icon(
            //           Icons.circle,
            //           color: Colors.lightGreen,
            //           size: 12, // Adjust the size as needed
            //         ),
            //       ),
            // ),
            if (pageIndexNotifier.value==2) Builder(
              builder: (ctx) => Align(
                alignment: const Alignment(1.2, 0.90),
                  child: InkWell(
                    onTap: () async{
                      //Get.offAll(() => LoginPage());
                      Navigator.of(ctx).pushNamed('/b');
                      SharedPreferences prefs=await SharedPreferences.getInstance();
                      prefs.setBool('x', true);
                      await authController.signInAny();
                    },
                    child: Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text('Next',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400),),
                        Icon(Icons.arrow_forward_ios_outlined,size: 35,color: Colors.lightGreen,)
                      ],
                    ),
                  ),

              ),
            ) else const Text(''),
          ],
        ),
      ),
    );
  }
}

class Ind9cator extends StatelessWidget {
  final int index;

  const Ind9cator(this.index);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0.7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildContainer(0, index == 0 ? Colors.green : Colors.red),
          buildContainer(1, index == 1 ? Colors.green : Colors.red),
          buildContainer(2, index == 2 ? Colors.green : Colors.red),
          buildContainer(3, index == 3 ? Colors.green : Colors.red),
        ],
      ),
    );
  }

  Widget buildContainer(int i, Color color) {
    return index == i
        ? Icon(
      Icons.star,
      color: color,
    )
        : Container(
      margin: const EdgeInsets.all(4),
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
