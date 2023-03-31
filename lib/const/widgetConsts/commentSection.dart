import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pr301/const/Myconsts/size.dart';
import 'package:pr301/const/Myconsts/colours.dart';

class Commentsection {
  Mycolours mycolours = Mycolours();
  ConstBoxes constBoxes = ConstBoxes();
  Widget commentWidget(String docId, BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          minHeight: MediaQuery.of(context).size.height * 0.2),
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("posts")
              .doc(docId)
              .collection("comments")
              .orderBy("time", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            return (!snapshot.hasData || snapshot.data?.docs.length == 0)
                ? Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 20,
                    color: mycolours.lg,
                    child: const Text("No comments..."),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      int? count = snapshot.data?.docs.length;
                      DocumentSnapshot data = snapshot.data?.docs[index]
                          as DocumentSnapshot<Object?>;
                      Map<String, dynamic> user = data['userr'];
                      return comments(
                          user['imageUrl'], user['name'], data['data']);
                    });
          }),
    );
  }

  Widget comments(String imageUrl, String name, String comment) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 15,
          ),
          constBoxes.commentPadding(),
          Container(
            decoration: BoxDecoration(
                color: mycolours.lg,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 13),
                  ),
                  constBoxes.horboxwithheigh_3(),
                  Text(
                    comment,
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget noComment() {
    return const SizedBox(
      height: 29,
      child: Text("No comments..."),
    );
  }

  Widget firstComment(String docId, double height) {
    return SizedBox(
      height: height,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("posts")
              .doc(docId)
              .collection("comments")
              .orderBy("time", descending: true)
              .limit(1)
              .snapshots(),
          builder: (context, snapshot) {
            return (!snapshot.hasData || snapshot.data?.docs.length == 0)
                ? Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: height,
                    color: mycolours.lg,
                    child: const Text("No comments..."),
                  )
                : ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      int? count = snapshot.data?.docs.length;
                      DocumentSnapshot data = snapshot.data?.docs[index]
                          as DocumentSnapshot<Object?>;
                      Map<String, dynamic> user = data['userr'];
                      return SizedBox(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(user['imageUrl']),
                              radius: 10,
                            ),
                            //ConstBoxes().commentPadding(),
                            SizedBox(
                              child: Text(data["data"]),
                            )
                          ],
                        ),
                      );
                    });
          }),
    );
  }

  Widget commentHeading() {
    return SizedBox(
      height: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          constBoxes.horboxwithheigh_20(),
          const Text(
            "Comments",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          constBoxes.horboxwithheigh_10(),
          constBoxes.line(1, 450)
        ],
      ),
    );
  }
}
