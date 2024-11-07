// ignore_for_file: file_names, prefer_const_constructors, avoid_print, dead_code
import 'package:flutter/material.dart';
import 'package:flutter_application_arda/screens/map.dart';

class ShowRoute extends StatelessWidget {
  ShowRoute({super.key});

  final List<Map<String, String>> stops = [
    {'name': 'Durak 1', 'duration': '20 dakika'},
    {'name': 'Durak 2', 'duration': '15 dakika'},
    {'name': 'Durak 3', 'duration': '30 dakika'},
    {'name': 'Durak 4', 'duration': '25 dakika'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Devam Eden Gezi',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: const Color.fromARGB(255, 11, 49, 115),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Haritada Göster',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),

            // Rota Adım Adım Gösterim
            Expanded(
              child: ListView.builder(
                itemCount: stops.length,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          if (index != stops.length - 1)
                            Container(
                                width: 2, height: 60, color: Colors.black),
                        ],
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stops[index]['name']!,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Önerilen süre: ${stops[index]['duration']}',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
