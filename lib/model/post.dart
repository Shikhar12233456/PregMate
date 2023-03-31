import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Post {
  Post(
      {required this.date,
      required this.title,
      required this.body,
      required this.userr,
      required this.likedList});

  factory Post.fromSnapshot(DataSnapshot snap) => Post(
      body: snap.child('body').value as String,
      date: snap.child('date').value as String,
      title: snap.child('title').value as String,
      userr: snap.child('userr') as Map<String, dynamic>,
      likedList: snap.child('likedList') as List);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'body': body,
      'date': date,
      'title': title,
      'userr': userr,
      'likedList': likedList
    };
  }

  final String date;
  final String title;
  final String body;
  final Map<String, dynamic> userr;
  final List likedList;
  factory Post.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Post(
        date: data?['date'],
        title: data?['title'],
        body: data?['body'],
        userr: data?['userr'],
        likedList: data?['likedList']);
  }
}
