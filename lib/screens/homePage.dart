// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_arda/weatherWidget.dart';
import 'getUserData.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment(-0.7, 1),
                child: Text(
                  'Merhaba,',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 15),
              Container(
                alignment: Alignment(-0.5, 1),
                child: Text(
                  'Bugün nereye gitmek istersin?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GetUserData()));
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
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 164),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    
                    WeatherWidget()
                    //Text('Hava durumu widget'),
                    //Text('UVA bilgileri'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
