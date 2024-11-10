import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPageHome extends StatelessWidget {
  const MapPageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(40.6539, 35.8331), // Coordinates for Amasya, Turkey
          zoom: 12,
        ),
        mapType: MapType.normal,
      ),
    );
  }
}
