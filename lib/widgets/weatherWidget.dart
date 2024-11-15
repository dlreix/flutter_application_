// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../weather.dart';

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  Future<Map<String, dynamic>>? _weatherData;

  @override
  void initState() {
    super.initState();
    _weatherData = fetchWeather('Amasya');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _weatherData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return Column(
            children: [
              Text('City: ${data['name']}'),
              Text('Temperature: ${data['main']['temp']}°C'),
              Text('Condition: ${data['weather'][0]['description']}'),
            ],
          );
        } else {
          return Text('No data available');
        }
      },
    );
  }
}
