import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pr301/const/Myconsts/size.dart';
import 'package:pr301/screens/chatScreens/indchat.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _user = FirebaseAuth.instance.currentUser;
  ConstBoxes cb = ConstBoxes();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Container(
          //   color: Colors.amber,
          //   height: MediaQuery.of(context).size.height * 0.123,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const Padding(
          //         padding: EdgeInsets.only(top: 5, left: 8, bottom: 4),
          //         child: Text(
          //           "Search",
          //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          //         ),
          //       ),
          //       SizedBox(
          //         height: MediaQuery.of(context).size.height * 0.076,
          //         child: StreamBuilder<QuerySnapshot>(
          //           stream: FirebaseFirestore.instance
          //               .collection("user")
          //               .snapshots(),
          //           builder: (context, snapshot) {
          //             return !snapshot.hasData
          //                 ? const SizedBox(
          //                     child: Text("No Users"),
          //                   )
          //                 : ListView.builder(
          //                     scrollDirection: Axis.horizontal,
          //                     itemCount: snapshot.data?.docs.length,
          //                     itemBuilder: (context, index) {
          //                       DocumentSnapshot data = snapshot.data
          //                           ?.docs[index] as DocumentSnapshot<Object?>;
          //                       return GestureDetector(
          //                         onTap: () {
          //                           Get.to(() => IndChat(peerId: data.id));
          //                         },
          //                         child: Padding(
          //                           padding:
          //                               const EdgeInsets.fromLTRB(8, 0, 8, 0),
          //                           child: SizedBox(
          //                             height: 40,
          //                             width: 40,
          //                             child: Column(
          //                               crossAxisAlignment:
          //                                   CrossAxisAlignment.start,
          //                               children: [
          //                                 CircleAvatar(
          //                                   backgroundImage:
          //                                       NetworkImage(data['imageUrl']),
          //                                 ),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                       );
          //                     });
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            alignment: Alignment.centerLeft,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Recent Chats",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
            ),
          ),
          cb.horboxwithheigh_20(),
          cb.line(1, MediaQuery.of(context).size.height * 0.9),
          cb.boswithpadd(25),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.68,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("user")
                  .doc(_user?.uid)
                  .collection("recentChats")
                  .orderBy("time", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? const SizedBox(
                        child: Text("No Users"),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data?.docs[index]
                              as DocumentSnapshot<Object?>;
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => IndChat(peerId: data.id));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(data['peerImageUrl']),
                                  ),
                                  ConstBoxes().commentPadding(),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Column(
                                      children: [
                                        Text(
                                          data['peerName'],
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        cb.boswithpadd(5),
                                        Text(data['recentChat'])
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    child: Text(cb.stdatetime(data['time'])),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
              },
            ),
          ),
        ],
      ),
    );
  }
}
