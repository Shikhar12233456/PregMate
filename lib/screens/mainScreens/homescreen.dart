import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pr301/auth/login.dart';
import 'package:pr301/const/bottomNabBar.dart';
import 'package:pr301/controllers/bottomnavbarController.dart';
import 'package:pr301/back/model/post.dart';
import 'package:pr301/screens/add_blog.dart';
import 'package:pr301/screens/chatScreens/chatPage.dart';
import 'package:pr301/screens/mainScreens/list.dart';
import 'package:pr301/screens/mainScreens/user_profile.dart';

import '../../back/firebase/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LoginController controller = Get.put(LoginController());
  final User? user = FirebaseAuth.instance.currentUser;
  String nodeName = 'posts';
  List<Post> postsList = <Post>[];

  @override
  Widget build(BuildContext context) {
    final BottomnavController bottomnavController =
        Get.put(BottomnavController(), permanent: false);
    final BottomNavBar bottomNavBar = BottomNavBar();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("PregCare"
            ),

          ),
          bottomNavigationBar: bottomNavBar.buildBottomNavigatorMenu(
              context, bottomnavController),
          body: Obx(
            () => IndexedStack(
              index: bottomnavController.tabIndex.value,
              children: const [BlogList(), ChatPage(), Userprofile()],
            ),
          )),
    );
  }

}
