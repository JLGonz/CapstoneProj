import 'package:cloud_firestore/cloud_firestore.dart';

import '../classes/user.dart';

import 'package:firebase_auth/firebase_auth.dart' as auth;

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> addUser(auth.UserCredential userCred) async {
    CollectionReference userCollection = _firestore.collection('users');

    return await userCollection
        .doc(userCred.user!.uid)
        .set(User(uid: userCred.user!.uid).createUserMap(userCred));
  }

  Stream<User?> getUser(String uid) {
    CollectionReference userCollection = _firestore.collection('users');

    return userCollection
        .doc(uid)
        .snapshots()
        .map((snapshot) => User.fromFirestore(snapshot));
  }
}
