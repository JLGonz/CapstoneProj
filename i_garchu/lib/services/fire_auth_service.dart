import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../classes/user.dart';
import 'firebase_firestore_service.dart';

class FireAuthService {
  final _firebaseAuth = auth.FirebaseAuth.instance;

  User? userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }

    return User(uid: user.uid, email: user.email);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(userFromFirebase);
  }

  Future<dynamic> signUp(
    String email,
    String password,
  ) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firestore = FirestoreService();
      firestore.addUser(credential); // Add user to Firestore collection
      return userFromFirebase(credential.user);
    } on auth.FirebaseAuthException catch (e) {
      return e;
    }
  }

  Future<dynamic> signIn(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userFromFirebase(credential.user);
    } on auth.FirebaseAuthException catch (e) {
      return e;
    }
  }

  Future<dynamic> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
