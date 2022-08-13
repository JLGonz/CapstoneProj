import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:i_garchu/Screens/auth.dart';
import 'package:i_garchu/Screens/login/login.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iGarchu Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.brown,
        scaffoldBackgroundColor: Color(0xF7C3B1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthScreen(),
    );
  }
}
