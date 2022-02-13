import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_proj/controller/auth_controller.dart';
import 'package:test_proj/screen/auth_screen/verify_email.dart';
import 'package:test_proj/screen/home_pages/main_screen.dart';

class SignUpPage extends StatelessWidget {
  static const String signup = 'Sign Up';
  static const String emailHint = 'Enter your Email';
  static const String passwordHint = 'Enter your Password';
  static const String usernameHint = 'Enter your UserName';
  static const String authFail = 'Authentication Fail';

  const SignUpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Scaffold(body: SafeArea(
      child: Obx(() {
        return authController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(Icons.arrow_back_ios)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'image/logo2.png',
                            width: 200,
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          const Text(
                            signup,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 35.0,
                            ),
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            alignment: Alignment.center,
                            decoration:
                                const BoxDecoration(color: Colors.white60),
                            child: TextField(
                                controller: authController.usernameController,
                                cursorColor: Colors.white,
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0.0),
                                    ),
                                    hintText: usernameHint,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.lightGreen, width: 0.0),
                                    ))),
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            alignment: Alignment.center,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: TextField(
                                controller: authController.emailController,
                                cursorColor: Colors.white,
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0.0),
                                    ),
                                    hintText: emailHint,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.lightGreen, width: 0.0),
                                    ))),
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            alignment: Alignment.center,
                            decoration:
                                const BoxDecoration(color: Colors.white),
                            child: TextField(
                                controller: authController.passwordController,
                                cursorColor: Colors.white,
                                decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0.0),
                                    ),
                                    hintText: passwordHint,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(width: 0.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.lightGreen, width: 0.0),
                                    ))),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text(
                                  'Already have an account?',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.indigoAccent,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                              child: GestureDetector(
                            onTap: () async {
                              await authController.signUp()
                                  ? Get.offAll(Main_Screen())
                                  : Get.snackbar(
                                      authFail, authController.errorText.value);
                              /* ? Get.offAll(const VerifyEmail())
                                      : Get.snackbar(
                                      authFail, authController.errorText.value);*/
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 60.0,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: const Text(
                                signup,
                                style: TextStyle(fontSize: 30.0),
                              ),
                            ),
                          )),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: <Widget>[
                              Container(),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
      }),
    ));
  }
}
