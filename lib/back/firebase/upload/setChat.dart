import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pr301/back/model/chat_room.dart';

class SetChat {
  Future<void> setChat(ChatRoom chatRoom, Map<String, dynamic> user, String text) async {
    if (await checkpresent(chatRoom)) {
      FirebaseFirestore.instance
          .collection("user")
          .doc(chatRoom.uid)
          .collection("recentChats")
          .doc(chatRoom.peerId)
          .set(chatRoom.toMap())
          .catchError((e) {
        if (kDebugMode) {
          print(e);
        }
      });

      FirebaseFirestore.instance
          .collection("user")
          .doc(chatRoom.peerId)
          .collection("recentChats")
          .doc(chatRoom.uid)
          .set(ChatRoom(
                  uid: chatRoom.peerId,
                  peerId: user['id'],
                  peerName: user['name'],
                  time: DateTime.now().toString(),
                  peerImageUrl: user['imageUrl'],
                  recentChat: text
                  )
              .toMap())
          .catchError((e) {
        print(e);
      });
    }
  }

  static Future<bool> checkpresent(ChatRoom chatRoom) async {
    bool peerexist = true;
    bool userexit = true;
    try {
      FirebaseFirestore.instance
          .collection("user")
          .doc(chatRoom.uid)
          .collection("recentChats")
          .doc(chatRoom.peerId)
          .get()
          .then((value) {
        peerexist = !value.exists;
      });

      FirebaseFirestore.instance
          .collection("user")
          .doc(chatRoom.peerId)
          .collection("recentChats")
          .doc(chatRoom.uid)
          .get()
          .then((value) {
        userexit = !value.exists;
      });
      return peerexist || userexit;
    } catch (e) {
      print(e);
    }
    return peerexist || userexit;
  }
}
