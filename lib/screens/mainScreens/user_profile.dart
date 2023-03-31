import 'package:flutter/material.dart';
import 'package:pr301/const/Myconsts/colours.dart';
import 'package:pr301/const/widgetConsts/userInfoTile.dart';
import 'package:pr301/firebase/firebase_auth.dart';
import 'package:pr301/firebase/upload/upload_profile.dart';

import '../../const/widgetConsts/loading.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({Key? key}) : super(key: key);

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  final Profile profile = Profile();
  Mycolours mycolours = Mycolours();
  Map<String, dynamic> doc = {};
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

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Loading()
        : Scaffold(
            // appBar: AppBar(
            //   elevation: 0,
            //   centerTitle: true,
            //   leading: IconButton(
            //     onPressed: () {},
            //     icon: const Icon(Icons.arrow_back_ios_new_outlined),
            //     color: Colors.blue,
            //   ),
            //   title: Text(
            //     "Profile",
            //     style: TextStyle(
            //         color: mycolours.lb,
            //         fontSize: 25,
            //         //fontFamily: ,
            //         fontWeight: FontWeight.w700),
            //   ),
            //   backgroundColor: Colors.white,
            //   actions: [
            //     TextButton(
            //         onPressed: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => UpdateProfile()));
            //         },
            //         child: const Text("Edit"))
            //   ],
            //   bottom: PreferredSize(
            //       preferredSize: const Size.fromHeight(0.1),
            //       child: Container(
            //         color: mycolours.lb,
            //         height: 1,
            //       )),
            // ),
            body: Card(
              child: Container(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(color: mycolours.lb, width: 3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(41)),
                        ),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(doc['imageUrl']),
                              radius: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(45, 45, 0, 0),
                              child: IconButton(
                                  alignment: Alignment.topCenter,
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.add_a_photo,
                                    color: mycolours.lightgrey,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: mycolours.lightblack, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            UserInfoTile(
                              info: doc['name'],
                              icon: Icons.person,
                            ),
                            UserInfoTile(icon: Icons.email, info: doc['email']),
                            UserInfoTile(
                                icon: Icons.phone_android,
                                info: doc['phoneNumber']),
                            UserInfoTile(
                                icon: Icons.person_2_rounded, info: doc['bio']),
                            TextButton(
                                onPressed: () {
                                  LoginController().logoutGoogle();
                                },
                                child: const Text("Logout"))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
