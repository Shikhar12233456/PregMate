import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:pr301/const/Myconsts/colours.dart';
import 'package:pr301/const/Myconsts/size.dart';
import 'package:pr301/const/widgetConsts/commentSection.dart';
import 'package:pr301/const/widgetConsts/loading.dart';
import 'package:pr301/firebase/upload/comment.dart';
import 'package:pr301/firebase/upload/upload_profile.dart';
import 'package:pr301/model/commentModel.dart';
import 'package:pr301/screens/mainScreens/homescreen.dart';
import '../const/widgetConsts/userInpost.dart';

class PostScreen extends StatefulWidget {
  PostScreen({Key? key, required this.document}) : super(key: key);
  DocumentSnapshot document;
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  Mycolours mycolours = Mycolours();
  Map<String, dynamic> doc = {};
  final Profile profile = Profile();
  TextEditingController commentController = TextEditingController();
  final Comment comment = Comment();
  bool isLoading = true;
  getUser() async {
    doc = (await profile.get())!;
    isLoading = false;
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
                    UserInPost(user: widget.document['userr']),
                    Text(
                      widget.document['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: mycolours.lightblack,
                    ),
                    Text(
                      widget.document[
                          'body'], /*style: GoogleFonts.lato(fontSize: 15),*/
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.heart,
                          color: mycolours.lightgrey,
                        ),
                        const Text("12"),
                      ],
                    ),
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
                          visible: commentController.text.isNotEmpty,
                          child: IconButton(
                              onPressed: () {
                                comment.addComment(
                                    CommentModel(
                                        time: DateTime.now().toString(),
                                        data: commentController.text,
                                        userr: doc),
                                    widget.document.id);
                                commentController.clear();
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
}
