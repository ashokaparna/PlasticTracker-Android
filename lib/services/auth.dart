import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plastic_tracker/user/app_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  AppUser _userFirebase(User user) {
    return user == null ? null : AppUser(uid: user.uid);
  }

  Stream<AppUser> get user {
    return _auth.authStateChanges().map(_userFirebase);
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      return _userFirebase(user);
    } catch (e) {
      return e;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      final User user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      return _userFirebase(user);
    } catch (e) {
      return e;
    }
  }

  //add user to db
  Future addUserToDb(String uid, String email, String username) async {
    return await userCollection.doc(uid).set({
      'uid': uid,
      'username': username,
      'email': email,
    });
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
