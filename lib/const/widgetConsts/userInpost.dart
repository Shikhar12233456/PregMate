import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pr301/const/Myconsts/colours.dart';

class UserInPost extends StatefulWidget {
  const UserInPost({Key? key, required this.user}) : super(key: key);
  final Map<String, dynamic> user;
  @override
  State<UserInPost> createState() => _UserInPostState();
}

class _UserInPostState extends State<UserInPost> {
  final Mycolours mycolours = Mycolours();
  final _userId = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 200,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: mycolours.lb),
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.user['imageUrl']),
                radius: 15,
              ),
            ),
          ),
          Text(
            widget.user['name'],
            style: const TextStyle(
                fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
