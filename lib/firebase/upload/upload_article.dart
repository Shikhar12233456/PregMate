import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pr301/model/post.dart';

class CrudMethods {
  Future<void> addData(Post post) async {
    FirebaseFirestore.instance
        .collection("posts")
        .add(post.toMap())
        .catchError((e) {
      print(e);
    });
  }

  getData() async {
    return FirebaseFirestore.instance.collection("posts").snapshots();
  }
}
