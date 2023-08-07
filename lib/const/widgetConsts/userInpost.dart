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
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 200,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: mycolours.lb),
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.user['imageUrl']),
                radius: 30,
              ),
            ),
          ),
          Text(
            widget.user['name'],
            style: const TextStyle(
                fontWeight: FontWeight.w700, color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
