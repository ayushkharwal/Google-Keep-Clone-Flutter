import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_keep_assignment1/utils/showSnackBar.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  // State Persistence
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  // Current User
  //final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  // Signup with email and password
  Future<void> signupWithEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message!);
    }
  }

  // Login with Email and pssword
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (!_auth.currentUser!.emailVerified) {
        await sendEmailVerification(context);
      }
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message!);
    }
  }

  // Email Verification
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showSnackbar(context, 'Email Verification sent!');
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message!);
    }
  }

  // Login Anonymously
  Future<void> signInAnonymously(BuildContext context) async {
    try {
      await _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message!);
    }
  }
}
