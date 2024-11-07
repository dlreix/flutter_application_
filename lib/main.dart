import 'package:flutter/material.dart';
import 'package:flutter_application_arda/screens/splash.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OptiRoute UI",
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}
