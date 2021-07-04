import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseGoogleApi {
  static final googleSignIn = GoogleSignIn();

  static Future<bool> login() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) throw Exception('No user');

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential.additionalUserInfo.isNewUser;
  }

  static Future<String> uploadImage(String path, File file) async {
    final ref = FirebaseStorage.instance.ref(path);
    final uploadTask = ref.putFile(file);
    await uploadTask.whenComplete(() {});

    return await ref.getDownloadURL();
  }

  static Future logout() async {
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }
  }
}
