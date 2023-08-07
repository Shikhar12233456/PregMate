import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pr301/const/Myconsts/colours.dart';
import 'package:pr301/back/model/user.dart';
import 'package:pr301/back/firebase/upload/upload_profile.dart';
import 'package:pr301/screens/mainScreens/homescreen.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({Key? key}) : super(key: key);
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late final _user = FirebaseAuth.instance.currentUser;
  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  final Profile profile = Profile();
  Mycolours mycolours = Mycolours();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.blue,
        ),
        title: Text(
          "Update Profile",
          style: TextStyle(
              color: mycolours.lb,
              fontSize: 25,
              //fontFamily: ,
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.1),
            child: Container(
              color: mycolours.lb,
              height: 1,
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(_user?.photoURL ??
                'https://freesvg.org/img/abstract-user-flat-4.png'),
            radius: 40,
          ),
          Container(
            height: 40,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Text(_user?.displayName ?? "no Name"),
          ),
          Container(
            height: 40,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Text(_user?.email ?? "no email"),
          ),
          TextField(
            textDirection: TextDirection.ltr,
            controller: phoneNumberController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2,
                    color: Colors.blue.withOpacity(.5)), //<-- SEE HERE
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
          TextField(
            controller: bioController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 2,
                    color: Colors.blue.withOpacity(.5)), //<-- SEE HERE
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
          TextButton(
              onPressed: () async {
                if (await Profile.check()) {
                  profile.update(userInfo());
                } else {
                  profile.set(userInfo());
                }
                Get.off(const Home());
              },
              child: const Text("add"))
        ],
      ),
    );
  }

  Userr userInfo() {
    return Userr(
        id: _user?.uid ?? "No id",
        email: _user?.email ?? "No mail",
        name: _user?.displayName ?? "No Name",
        phoneNumber: phoneNumberController.text,
        bio: bioController.text,
        imageUrl: _user?.photoURL ?? "",
        followers: []);
  }
}
