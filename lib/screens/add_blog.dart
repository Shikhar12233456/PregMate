import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:pr301/const/Myconsts/colours.dart';
import 'package:pr301/const/widgetConsts/loading.dart';
import 'package:pr301/firebase/upload/upload_article.dart';
import 'package:pr301/firebase/upload/upload_profile.dart';
import 'package:pr301/model/post.dart';

class AddBlog extends StatefulWidget {
  AddBlog({Key? key}) : super(key: key);

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  TextEditingController tittlecontroller = TextEditingController();
  TextEditingController postcontoller = TextEditingController();
  DateTime date = DateTime.now();
  final uName = FirebaseAuth.instance.currentUser?.displayName;
  final Profile profile = Profile();
  Map<String, dynamic> doc = {};
  List likedList = [];
  // Userr? userr;
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

  CrudMethods crudMethods = CrudMethods();
  Mycolours mycolours = Mycolours();
  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
              title: const Text("Add Post"),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        controller: tittlecontroller,
                        decoration: const InputDecoration(
                            labelText: "Title", hintText: "Title"),
                      ),
                      TextField(
                        controller: postcontoller,
                        decoration: const InputDecoration(
                            hintText: "your blog's body...",
                            border: InputBorder.none),
                        maxLines: null,
                        autocorrect: true,
                      ),
                      TextButton(
                          onPressed: () {
                            if (tittlecontroller.text == "" ||
                                postcontoller.text == "") {
                              const snackBar = SnackBar(
                                content: Text(
                                    'Title or ${"blog's body cann't"} be empty'),
                                duration: Duration(milliseconds: 70),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              crudMethods.addData(Post(
                                  date: DateTime.now().toString(),
                                  title: tittlecontroller.text,
                                  body: postcontoller.text,
                                  userr: doc,
                                  likedList: likedList));
                              Get.back();
                            }
                          },
                          child: const Text("POST"))
                    ]),
              ),
            ),
          );
  }
}
