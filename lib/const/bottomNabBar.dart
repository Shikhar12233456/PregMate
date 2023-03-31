import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pr301/const/Myconsts/colours.dart';
import 'package:pr301/controllers/bottomnavbarController.dart';

class BottomNavBar {
  final TextStyle unselectedstyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);
  final TextStyle selectedStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );

  buildBottomNavigatorMenu(context, BottomnavController bottomnavController) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: SizedBox(
          height: 54,
          child: BottomNavigationBar(
              showUnselectedLabels: true,
              showSelectedLabels: true,
              onTap: bottomnavController.changeIndex,
              currentIndex: bottomnavController.tabIndex.value,
              unselectedItemColor: Colors.white.withOpacity(0.5),
              selectedItemColor: Colors.white,
              unselectedLabelStyle: unselectedstyle,
              selectedLabelStyle: selectedStyle,
              backgroundColor: Mycolours().lb,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 7),
                    child: const Icon(
                      Icons.home,
                      size: 20.0,
                    ),
                  ),
                  label: 'Home',
                  backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 7),
                    child: const Icon(
                      Icons.chat,
                      size: 20.0,
                    ),
                  ),
                  label: 'Chat',
                  backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 7),
                    child: const Icon(
                      Icons.person_2_rounded,
                      size: 20.0,
                    ),
                  ),
                  label: 'Profile',
                  backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
                ),
              ]),
        )));
  }
}
