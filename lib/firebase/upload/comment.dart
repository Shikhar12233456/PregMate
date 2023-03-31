import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pr301/model/commentModel.dart';

class Comment {
  Future<void> addComment(CommentModel commentModel, String postid) async {
    try {
      await FirebaseFirestore.instance
          .collection("posts")
          .doc(postid)
          .collection("comments")
          .add(commentModel.tomap())
          .catchError((e) {});
    } catch (e) {
      print(e);
    }
  }

  Future<void> getFirst(String pid) async {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(pid)
        .collection("comments")
        .snapshots()
        .first;
  }

  Future<int> commentCount() {
    return FirebaseFirestore.instance
        .collection("posts")
        .doc()
        .collection("comments")
        .snapshots()
        .length;
  }
}
