import 'package:flutter/material.dart';
import 'package:pr301/const/Myconsts/colours.dart';

class ConstBoxes {
  Mycolours mycolours = Mycolours();
  Widget horboxwithheigh_20() {
    return const SizedBox(
      height: 20,
    );
  }

  Widget horboxwithheigh_10() {
    return const SizedBox(
      height: 10,
    );
  }

  Widget boswithpadd(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget horboxwithheigh_3() {
    return const SizedBox(
      height: 3,
    );
  }

  Widget line(double height, double width) {
    return Container(
      color: mycolours.lightgrey,
      height: height,
      width: width,
    );
  }

  Widget commentPadding() {
    return const SizedBox(
      height: 30,
      width: 12,
    );
  }

  Widget sbx() {
    return const SizedBox(
      height: 30,
      width: 25,
    );
  }

  Widget boxPadd() {
    return const Padding(padding: EdgeInsets.all(8));
  }

  String stdatetime(String date) {
    DateTime dateTime = DateTime.parse(date);
    int hr = dateTime.hour;
    String min = dateTime.minute.toString();
    if (int.parse(min) <= 9) {
      min = "0$min";
    }
    return "$hr:$min";
  }
}
