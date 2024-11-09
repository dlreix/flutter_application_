// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_arda/screens/map.dart';
import 'package:flutter_application_arda/widgets/weatherWidget.dart';
import 'getUserData.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Ekranlar listesi
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(), // Ana sayfa
    MapPage(), // Harita sayfası
  ];

  // BottomNavigationBar'daki öğeye tıklanınca yapılacak işlem
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body kısmı (seçilen sayfa)
      body: _widgetOptions.elementAt(_selectedIndex),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color.fromARGB(255, 11, 49, 115),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.map_outlined,
              color: Color.fromARGB(255, 11, 49, 115),
            ),
            label: 'Map',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Ana sayfa widget'ı
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Merhaba,',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              Text(
                'Bugün nereye gitmek istersin?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GetUserData()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green, // Butonun yazı rengi
                  padding: EdgeInsets.symmetric(
                      horizontal: 100, vertical: 10), // İç boşluklar
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15), // Yuvarlatılmış kenarlar
                  ),
                ),
                child: Text(
                  'Rota Oluştur!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 180),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [WeatherWidget()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
