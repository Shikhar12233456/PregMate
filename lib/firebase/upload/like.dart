import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Like {
  static Future<bool> check(String id, String uid) async {
    bool exist = false;
    try {
      // FirebaseFirestore.instance.collection("post
    } catch (e) {
      print(e);
    }
    return exist;
  }

  Future<List> get(String postId) async {
    Map<String, dynamic> doc = {};
    try {
      DocumentSnapshot data = await FirebaseFirestore.instance
          .collection("posts")
          .doc(postId)
          .get();

      doc = data.data() as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
    return doc['likedList'];
  }

  Future<void> addtoLikeList(String uid, String pid) async {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(pid)
        .collection("likes")
        .doc(uid)
        .set({"uid": uid}).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
  }

  Future<void> removeFromLikeList(String uid, String pid) async {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(pid)
        .collection("likes")
        .doc(uid)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}
