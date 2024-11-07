// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Harita',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 11, 49, 115),
      ),
      body: Center(
        child: Text(
          'Harita buraya gelecek',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
