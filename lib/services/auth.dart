import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //logout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (err) {
      print(err);
      return null;
    }
  }

  // check user role
  Future checkUserRole(uid) async {
    final collectionUser =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (collectionUser['role'] == 'admin') {
      return user;
    } else {
      await signOut();
      return null;
    }
  }

  // delete user
  Future deleteUser(data,index) async {
    FirebaseFirestore.instance
      .collection('users')
      .doc(data.docs[index].id)
      .delete()
      .then((_) {})
      .catchError((err) => print(err.toString()));
  }
}
