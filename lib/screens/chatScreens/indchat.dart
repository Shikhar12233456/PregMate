import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pr301/const/chatwidget/chatwidget.dart';
import 'package:pr301/const/widgetConsts/loading.dart';
import 'package:pr301/firebase/upload/createChat.dart';
import 'package:pr301/firebase/upload/setChat.dart';
import 'package:pr301/firebase/upload/upload_profile.dart';
import 'package:pr301/model/chat.dart';
import 'package:pr301/model/chat_room.dart';
import 'package:pr301/screens/chatScreens/chatPage.dart';

class IndChat extends StatefulWidget {
  IndChat({Key? key, required this.peerId}) : super(key: key);
  final String peerId;
  @override
  State<IndChat> createState() => _IndChatState();
}

class _IndChatState extends State<IndChat> {
  Map<String, dynamic> user = {};
  Map<String, dynamic> peer = {};
  UploadChat uploadChat = UploadChat();
  String tt = "";
  bool submit = false;
  bool _isloading = true;
  TextEditingController textEditingController = TextEditingController();
  getUser() async {
    user = (await Profile().get())!;
    peer = (await Profile().getbyUid(widget.peerId))!;
    tt = uploadChat.setId(user['id'], widget.peerId);
    _isloading = false;
    setState(() {
      submit = textEditingController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return _isloading == true
        ? const Loading()
        : Scaffold(
            //backgroundColor: Colors.black,
            appBar: AppBar(
              leading: Container(
                color: Colors.black,
                child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back)),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(peer['imageUrl']),
                    radius: 18,
                  ),
                  Text(peer['name'],style: const TextStyle(fontWeight: FontWeight.w600),)
                ],
              ),
              //title: Text(peer['name']),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ChatWidget().chatWidget(
                      tt, user['id'], MediaQuery.of(context).size.height * 0.8),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: TextField(
                            controller: textEditingController,
                            autocorrect: true,
                            decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.all(13),
                                hintText: "Type your Message",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)))),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: textEditingController.value.text.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: () {
                                submitdata();
                              },
                              icon: const Icon(
                                Icons.send,
                                color: Colors.blue,
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  submitdata() {
    String chatid = uploadChat.setId(user['id'], widget.peerId);
    if (textEditingController.text.isNotEmpty) {
      uploadChat.message(
          Chat(
              message: textEditingController.text,
              userId: user['id'],
              peerId: widget.peerId,
              time: DateTime.now().toString()),
          chatid);

      SetChat().setChat(
          ChatRoom(
              uid: user['id'],
              peerId: peer['id'],
              peerName: peer['name'],
              time: DateTime.now().toString(),
              peerImageUrl: peer['imageUrl']),
          user);
    } else {
      print("empty message");
    }
    textEditingController.clear();
  }
}
