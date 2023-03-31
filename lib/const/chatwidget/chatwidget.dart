import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:pr301/const/Myconsts/colours.dart';

class ChatWidget {
  Widget chatWidget(String chatId, String uid, double height) {
    return SizedBox(
      height: height,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("chats")
              .doc(chatId)
              .collection("messages")
              .orderBy("time", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            //print("called");
            return !snapshot.hasData
                ? SizedBox(
                    height: height,
                  )
                : ListView.builder(
                    reverse: true,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = snapshot.data?.docs[index]
                          as DocumentSnapshot<Object?>;
                      return uid == data['userId']
                          ? messageWidget(
                              data['message'],
                              stdatetime(data['time']),
                              Alignment.bottomRight,
                              Mycolours().ligthgreen)
                          : messageWidget(
                              data['message'],
                              stdatetime(data['time']),
                              Alignment.bottomLeft,
                              Mycolours().lg);
                    });
          }),
    );
  }

  Widget messageWidget(String data, String time,
      AlignmentGeometry alignmentGeometry, Color color) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 275),
        alignment: alignmentGeometry,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Bubble(
          elevation: 0,
          color: color,
          nip: alignmentGeometry == Alignment.bottomRight
              ? BubbleNip.rightTop
              : BubbleNip.leftTop,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Text(
                time,
                // style: GoogleFonts.lato(
                //     fontSize: 12,
                //     fontWeight: FontWeight.w400,
                //     color: Colors.black.withOpacity(0.6)),
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 270),
                child: Padding(
                  padding: const EdgeInsets.only(right: 30, bottom: 10),
                  child: Text(
                    data,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.9)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
