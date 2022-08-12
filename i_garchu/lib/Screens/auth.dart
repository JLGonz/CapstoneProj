import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i_garchu/Screens/homescreen.dart';
import 'package:provider/provider.dart';

import '../classes/user.dart';
import '../services/fire_auth_service.dart';
import '../services/firebase_firestore_service.dart';
import 'login/login.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<FireAuthService>(context);
    final firestore = FirestoreService();
    // Handle User Firebase Authentication
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          return user == null
              ? LoginScreen()
              : StreamProvider<User?>.value(
                  // Maintain User state to HomeScreen
                  value: firestore.getUser(user.uid),
                  initialData: user,
                  child: const HomeScreen(),
                  catchError: (_, error) {
                    return null;
                  },
                );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
