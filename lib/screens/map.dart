// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert'; // JSON parsing
import 'package:http/http.dart' as http;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  List<LatLng> coordinates = []; // Ziyaret edilecek koordinatlar

  @override
  void initState() {
    super.initState();
    _fetchCoordinates(); // Sunucudan verileri al
  }

  // Sunucudan koordinatları almak için HTTP isteği
  Future<void> _fetchCoordinates() async {
    final response =
        await http.get(Uri.parse('https://api.example.com/coordinates'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<dynamic> coordinatesData =
          data['coordinates']; // Sunucudan gelen veri yapısına göre düzenleyin

      setState(() {
        coordinates = coordinatesData
            .map((coord) => LatLng(coord['latitude'], coord['longitude']))
            .toList();

        // Markers ekleyin
        _markers = coordinates
            .asMap()
            .map((index, coord) => MapEntry(
                  index,
                  Marker(
                    markerId: MarkerId('marker_$index'),
                    position: coord,
                    infoWindow: InfoWindow(
                      title: 'Visit ${index + 1}',
                    ),
                  ),
                ))
            .values
            .toSet();
      });
    } else {
      throw Exception('Failed to load coordinates');
    }
  }

  // Google Map Controller'ı ayarlama
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Page'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(
              37.7749, -122.4194), // Başlangıç konumu (örnek: San Francisco)
          zoom: 12,
        ),
        markers: _markers,
        mapType: MapType.normal,
      ),
    );
  }
}
