// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_arda/screens/homePage.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/optiRoute.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(
                bottom:
                    100), // Sayfanın 3'te 2'lik alt kısmında olmasını sağlar
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Text(
                  'OptiRoute',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight
                          .bold), // İstediğiniz stil özelliklerini ekleyebilirsiniz
                ),
                SizedBox(height: 20), // 20 px boşluk
                Text(
                  'Kişiselleştirilmiş rotalar',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                Text(
                  'oluşturmak için geliştirilmiştir.',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 60)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
