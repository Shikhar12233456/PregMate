import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:pr301/const/Myconsts/colours.dart';
import 'package:pr301/const/Myconsts/size.dart';
import 'package:pr301/const/widgetConsts/commentSection.dart';
import 'package:pr301/const/widgetConsts/loading.dart';
import 'package:pr301/back/firebase/upload/comment.dart';
import 'package:pr301/back/firebase/upload/upload_profile.dart';
import 'package:pr301/back/model/commentModel.dart';
import 'package:pr301/screens/mainScreens/homescreen.dart';
import '../const/widgetConsts/userInpost.dart';

class PostScreen extends StatefulWidget {
  PostScreen({Key? key, required this.document}) : super(key: key);
  DocumentSnapshot document;
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  var currUserId = FirebaseAuth.instance.currentUser?.uid;
  var currentUsermail = FirebaseAuth.instance.currentUser?.email;
  Mycolours mycolours = Mycolours();
  Map<String, dynamic> doc = {};
  final Profile profile = Profile();
  TextEditingController commentController = TextEditingController();
  final Comment comment = Comment();
  ConstBoxes cb = ConstBoxes();
  bool isLoading = true;
  Map<String, dynamic> user = {};
  List likedList = [];
  int len = 0;
  List follower = [];
  bool checkfollower = false;
  bool check = false;

  getUser() async {
    doc = (await profile.get())!;
    isLoading = false;
    user = widget.document['userr'];
    likedList = widget.document['likedList'];
    len = likedList.length;
    follower = user['follower'];
    checkfollower = follower.contains(currUserId);
    check = likedList.contains(currUserId);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: const Text("Post Screen"),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Get.offAll(const Home());
                },
              ),
            ),
            body: SingleChildScrollView(
                child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // To fetch User's profile in the post's screen
                    UserInPost(user: widget.document['userr']),

                    // title of text;
                    Text(
                      widget.document['title'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    cb.horboxwithheigh_20(),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: mycolours.lightblack,
                    ),
                    cb.boswithpadd(30),
                    Text(
                      widget.document['body'],
                      style: GoogleFonts.lato(fontSize: 15),
                    ),
                    cb.boswithpadd(20),
                    // like ans count of likes---------
                    likeAndCount(check, widget.document.id, len.toString()),

                    // Comment's view --------------

                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(doc['imageUrl']),
                          radius: 16,
                        ),
                        ConstBoxes().commentPadding(),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.65,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: mycolours.lightgrey, width: 1.5)),
                          child: TextField(
                            autocorrect: true,
                            controller: commentController,
                            decoration: const InputDecoration(
                                hintText: "Comment", border: InputBorder.none),
                          ),
                        ),
                        Visibility(
                          visible: (commentController.text.isNotEmpty &&
                              (commentController.text != "")),
                          child: IconButton(
                              onPressed: () {
                                if (commentController.text == "" ||
                                    commentController.text.isEmpty) {
                                  const snackBar = SnackBar(
                                    content: Text("Comment cann't be empty"),
                                    duration: Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else if (currentUsermail ==
                                    widget.document['userr']['email']) {
                                  const snackBar = SnackBar(
                                    content: Text(
                                        "You cann't comment on your blog..."),
                                    duration: Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  comment.addComment(
                                      CommentModel(
                                          time: DateTime.now().toString(),
                                          data: commentController.text,
                                          userr: doc),
                                      widget.document.id);
                                  commentController.clear();
                                }
                              },
                              icon: const Icon(Icons.send)),
                        )
                      ],
                    ),
                    Commentsection().commentHeading(),
                    Commentsection().commentWidget(widget.document.id, context),
                  ],
                ),
              ),
            )),
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
}
