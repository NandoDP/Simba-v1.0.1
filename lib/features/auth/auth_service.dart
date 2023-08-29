import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simba/features/auth/dbservice.dart';
import 'package:simba/models/user_model.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserM? _userFromFirebaseUser(User? user) {
    return user != null
        ? UserM(
            name: user.displayName!,
            profilePic: user.photoURL!,
            uid: user.uid,
            isAuthenticated: true,
            communities: [],
          )
        : null;
  }

  Stream<UserM?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (exception) {
      debugPrint(exception.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user == null) {
        throw Exception("No user found");
      } else {
        await DatabaseService(user.uid).saveUser(name, 0);

        return _userFromFirebaseUser(user);
      }
    } catch (exception) {
      debugPrint(exception.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (exception) {
      debugPrint(exception.toString());
      return null;
    }
  }
}
