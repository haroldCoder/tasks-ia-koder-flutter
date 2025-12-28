import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  final bool logged;
  final User? currentUser;

  AuthState({this.logged = false, this.currentUser});

  AuthState copyWith({
    bool? logged,
    User? currentUser,
  }) {
    return AuthState(
      logged: logged ?? this.logged,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}

class AuthService extends StateNotifier<AuthState> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
  );
  late SharedPreferences prefs;

  AuthService() : super(AuthState()) {
    _loadLoggedState();
  }

  Future<void> _loadLoggedState() async {
    prefs = await SharedPreferences.getInstance();
    final loggedValue = prefs.getBool('logged') ?? false;
    final userJson = prefs.getString("data_user");
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (userJson != null && firebaseUser != null) {
      state = AuthState(logged: loggedValue, currentUser: firebaseUser);
    } else {
      state = AuthState(logged: loggedValue);
    }
  }

  Future<void> signInWithGoogle() async {
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

      final user = userCredential.user;

      if (user != null) {
        final userMap = {
          'uid': user.uid,
          'displayName': user.displayName,
          'email': user.email,
          'photoURL': user.photoURL,
        };
        final userJson = jsonEncode(userMap);
        await prefs.setString('data_user', userJson);
      }

      await prefs.setBool('logged', true);

      state = AuthState(logged: true, currentUser: user);
    } catch (e) {
      print("Error al iniciar sesión: $e");
    }
  }

  Future<void> logoutGoogle() async {
    try {
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      await prefs.setBool('logged', false);
      await prefs.remove('data_user');
      state = AuthState(logged: false, currentUser: null);
    } catch (e) {
      print(e);
    }
  }
}

final authServiceProvider =
    StateNotifierProvider<AuthService, AuthState>((ref) {
  return AuthService();
});
