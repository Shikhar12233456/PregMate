import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pr301/model/chat.dart';
import 'package:pr301/model/chat_room.dart';

class UploadChat {
  Future<void> message(Chat chat, String chatid) async {
    FirebaseFirestore.instance
        .collection("chats")
        .doc(chatid)
        .collection("messages")
        .add(chat.tomap())
        .catchError((e) {
      print((e.toString()));
    });

    FirebaseFirestore.instance
        .collection("chats")
        .doc(chatid)
        .set(chat.tomap())
        .catchError((e) {
      print(e);
    });
  }

  Future<void> setInfo(ChatRoom chatRoom, String chatid) async {
    FirebaseFirestore.instance
        .collection("chats")
        .doc(chatid)
        .set(chatRoom.toMap())
        .catchError((e) {
      print(e);
    });
  }

  String setId(String user, String peer) {
    if (user.hashCode > peer.hashCode) {
      return "${user}_$peer";
    } else {
      return "${peer}_$user";
    }
  }
}

// class GetChat {
//   Future<Map<String, dynamic>?> getrecentChat(String chatId) async {
//     try {
//       DocumentSnapshot snapshot = await FirebaseFirestore.instance
//           .collection("chats")
//           .doc(chatId)
//           .get();
//       print(snapshot.data());
//       return snapshot.data() as Map<String, dynamic>;
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }
// }
