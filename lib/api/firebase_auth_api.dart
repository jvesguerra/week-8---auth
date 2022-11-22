import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:week7_networking_discussion/screens/login.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  BuildContext? get context => null;
  // final db = FakeFirebaseFirestore();

  // final auth = MockFirebaseAuth(
  //     mockUser: MockUser(
  //   isAnonymous: false,
  //   uid: 'someuid',
  //   email: 'charlie@paddyspub.com',
  //   displayName: 'Charlie',
  // ));

  Stream<User?> getUser() {
    return auth.authStateChanges();
  }

  void signIn(String email, String password) async {
    UserCredential credential;
    try {
      final credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //possible to return something more useful
        //than just print an error message to improve UI/UX
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  // Future<String> signIn(String email, String password) async {
  //   UserCredential credential;
  //   try {
  //     final credential = await auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       //possible to return something more useful
  //       //than just print an error message to improve UI/UX
  //       //print('No user found for that email.');
  //       return 'No user found for that email.';
  //     } else if (e.code == 'wrong-password') {
  //       //print('Wrong password provided for that user.');
  //       return "Wrong password";
  //     }
  //   }
  //   return "tet";
  // }

  void signUp(
      String email, String password, String firstName, String lastName) async {
    UserCredential credential;
    try {
      credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        saveUserToFirestore(credential.user?.uid, email, firstName, lastName);
      }
    } on FirebaseAuthException catch (e) {
      //possible to return something more useful
      //than just print an error message to improve UI/UX
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void saveUserToFirestore(
      String? uid, String email, String firstName, lastName) async {
    try {
      await db
          .collection("users")
          .doc(uid)
          .set({"email": email, "firstName": firstName, "lastName": lastName});
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  void signOut() async {
    auth.signOut();
  }
}
