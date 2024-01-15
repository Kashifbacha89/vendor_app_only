import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vendor_app_only/vendor/views/auth/vendor_registration_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAWDdj9AQS1jGnzKqdNq2GvrhvuPvjFD8I",
        appId: "1:761654940887:android:2b2a6192524f9b3a25cc92",
        messagingSenderId: "761654940887",
        projectId: "my-personal-project-d4328",
      storageBucket: "my-personal-project-d4328.appspot.com"

    ),
  ):Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const VendorRegistrationScreen(),
    );
  }
}


