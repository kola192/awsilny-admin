import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // auth change user stream
  Stream<User?> get user {
    // return _auth
    //     .authStateChanges()
    //     .map((User? user) => _userFromFirebaseUser(user!));
    return _auth.authStateChanges();
  }

  //sign in with email and pass
  Future signIn(email, password) async {
    try {
      print(email);
      print(password);
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User? user = userCredential.user;
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  //sign up with email and pass

  //logout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (err) {
      print(err);
      return null;
    }
  }
}
