import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pr301/back/model/user.dart';

class Profile {
  final _uid = FirebaseAuth.instance.currentUser?.uid;

  static Future<bool> check() async {
    bool exist = false;
    try {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get()
          .then((value) {
        exist = value.exists;
      });
    } catch (e) {
      return false;
    }
    return exist;
  }

  Future<Map<String, dynamic>?> get() async {
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection("user").doc(_uid).get();

      return doc.data() as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
    // return null;
  }

  Future<Map<String, dynamic>?> getbyUid(String uid) async {
    //Map<String, dynamic> user = {};
    try {
      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection("user").doc(uid).get();
      return doc.data() as Map<String, dynamic>;
    } catch (e) {
      print(e);
    }
    //return user;
  }

  Future<void> set(Userr userr) async {
    FirebaseFirestore.instance
        .collection("user")
        .doc(_uid)
        .set(userr.toMap())
        .catchError((e) {
      print(e);
    });
  }

  Future<void> update(Userr userr) async {
    FirebaseFirestore.instance
        .collection("user")
        .doc(_uid)
        .update(userr.toMap())
        .catchError((e) {
      print(e);
    });
  }
}
