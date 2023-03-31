import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:pr301/const/Myconsts/colours.dart';
import 'package:pr301/const/Myconsts/size.dart';
import 'package:pr301/firebase/upload/upload_profile.dart';
import 'package:pr301/screens/add_blog.dart';
import 'package:pr301/screens/postScreen.dart';

class BlogList extends StatefulWidget {
  const BlogList({Key? key}) : super(key: key);

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  final Mycolours mycolours = Mycolours();
  var currUserId = FirebaseAuth.instance.currentUser?.uid;
  var currUserName = FirebaseAuth.instance.currentUser?.displayName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("posts")
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data =
                        snapshot.data?.docs[index] as DocumentSnapshot<Object?>;
                    Map<String, dynamic> user = data['userr'];
                    List likedList = data['likedList'];
                    int len = likedList.length;
                    List follower = user['follower'];
                    bool checkfollower = follower.contains(currUserId);
                    bool check = likedList.contains(currUserId);
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            userInPost(user['name'], user['imageUrl'],
                                checkfollower, user['id']),
                            Text(
                              data['title'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                              color: mycolours.lightblack,
                            ),
                            Container(
                                constraints: BoxConstraints(
                                    maxHeight:
                                        MediaQuery.of(context).size.height *
                                            0.4),
                                child: Text(
                                  data['body'],
                                  // style: GoogleFonts.lato(),
                                )),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      width: MediaQuery.of(context).size.width *
                                          .4,
                                      decoration: BoxDecoration(
                                          color: mycolours.lg.withOpacity(0.15),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      child: likeAndCount(
                                          check, data.id, len.toString())),
                                  Container(
                                      alignment: Alignment.center,
                                      height: 40,
                                      width: MediaQuery.of(context).size.width *
                                          .4,
                                      decoration: BoxDecoration(
                                          color: mycolours.lg.withOpacity(0.15),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20))),
                                      child: commentButton(data)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.withOpacity(0.75),
        onPressed: () {
          Get.to(() => AddBlog());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget likeAndCount(bool check, String id, String len) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ConstBoxes().sbx(),
          IconButton(
              onPressed: () {
                if (check == true) {
                  FirebaseFirestore.instance.collection("posts").doc(id).set({
                    "likedList": FieldValue.arrayRemove([currUserId])
                  }, SetOptions(merge: true));
                } else {
                  FirebaseFirestore.instance.collection("posts").doc(id).set({
                    "likedList": FieldValue.arrayUnion([currUserId])
                  }, SetOptions(merge: true));
                }
              },
              icon: check == true
                  ? Icon(
                      CupertinoIcons.heart_solid,
                      color: Colors.red.withOpacity(0.8),
                    )
                  : Icon(
                      CupertinoIcons.heart,
                      color: Colors.black.withOpacity(0.5),
                    )),
          Text(
            len,
            style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 17,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget commentButton(DocumentSnapshot documentSnapshot) {
    return IconButton(
        onPressed: () {
          Get.to(() => PostScreen(document: documentSnapshot));
        },
        icon: Icon(
          Icons.comment_outlined,
          color: Colors.black.withOpacity(0.6),
        ));
  }

  Widget userInPost(String name, String imageUrl, bool check, String id) {
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
                backgroundImage: NetworkImage(imageUrl),
                radius: 15,
              ),
            ),
          ),
          Text(
            name,
            style: const TextStyle(
                fontWeight: FontWeight.w700, color: Colors.black),
          ),
          // TextButton(
          //     onPressed: () {
          //       if (check == true) {
          //         FirebaseFirestore.instance.collection("user").doc(id).update({
          //           "follower": FieldValue.arrayRemove([currUserId])
          //         });
          //       } else {
          //         FirebaseFirestore.instance.collection("user").doc(id).update({
          //           "follower": FieldValue.arrayUnion([currUserId])
          //         });
          //       }
          //     },
          //     child: check == true
          //         ? const Text("Following")
          //         : const Text("Follow"))
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> user2(String id) async {
    return (await Profile().getbyUid(id))!;
  }
}
