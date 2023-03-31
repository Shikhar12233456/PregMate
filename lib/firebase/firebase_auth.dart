import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pr301/firebase/upload/upload_profile.dart';
import 'package:pr301/screens/mainScreens/homescreen.dart';
import 'package:pr301/screens/user/update_profile.dart';

import '../auth/login.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  loginInWIthGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      await _auth.signInWithCredential(credential);
      final userId = FirebaseAuth.instance.currentUser?.uid;
      // ignore: unrelated_type_equality_checks
      // if (Profile().getbyUid(userId!) != Null) {
      //   Get.offAll(() => const Home());
      // } else {
        Get.offAll(() => UpdateProfile());
      // }
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e.message);
      rethrow;
    }
  }

  Future<void> logoutGoogle() async {
    await _googleSignIn.signOut();
    Get.offAll(() => Login());
  }
}
