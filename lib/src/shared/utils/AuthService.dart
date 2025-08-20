import 'dart:convert';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
  );
  late SharedPreferences prefs;
  Rx<bool> logged = false.obs;
  Rx<User?> current_user = Rx<User?>(null);

  AuthService() {
    _loadLoggedState();
  }

  @override
  void onInit() {
    super.onInit();
    _loadLoggedState();
  }

  Future<void> _loadLoggedState() async {
    prefs = await SharedPreferences.getInstance();
    logged.value = prefs.getBool('logged') ?? false;
    final userJson = prefs.getString("data_user");
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (userJson != null && firebaseUser != null) {
      current_user.value = firebaseUser;
    }
  }

  Future<void> SignInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      logged.value = true;
      current_user.value = userCredential.user;
      if (current_user.value != null) {
        final userMap = {
          'uid': current_user.value!.uid,
          'displayName': current_user.value!.displayName,
          'email': current_user.value!.email,
          'photoURL': current_user.value!.photoURL,
        };
        final userJson = jsonEncode(userMap);
        await prefs.setString('data_user', userJson);
      }
      await prefs.setBool('logged', logged.value);
    } catch (e) {
      print("Error al iniciar sesión: $e");
    }
  }

  Future<void> logoutGoogle() async {
    try {
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      logged.value = false;
      current_user.value = null;
      await prefs.setBool('logged', logged.value);
      await prefs.remove('data_user');
    } catch (e) {
      print(e);
    }
  }
}
