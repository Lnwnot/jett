import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jetts_fitness_app/screens/login_screen.dart';
import 'firebase_options.dart'; // Import the Firebase options file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Use FirebaseOptions
  );
  runApp(const JettsApp());
}

class JettsApp extends StatelessWidget {
  const JettsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LoginScreen(),
    );
  }
}