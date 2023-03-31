import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pr301/const/splashscreen.dart';
import 'package:pr301/firebase/firebase_auth.dart';
import 'package:pr301/screens/mainScreens/homescreen.dart';
import 'package:pr301/screens/user/update_profile.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/backgr.jpg",
              fit: BoxFit.fill,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "PregCare",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 56,
                    color: Colors.white.withOpacity(0.7)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
              ),
              TextButton(
                onPressed: () {
                  controller.loginInWIthGoogle();
                },
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20,
                        child: Image.asset(
                          "assets/images/google-removebg-preview.png",
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const Text(
                        "Login with google",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
