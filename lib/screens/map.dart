import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  final List<dynamic> dataList;

  MapPage({required this.dataList});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  List<LatLng> _routeCoordinates = []; // Coordinates for the polyline route

  @override
  void initState() {
    super.initState();
    _initializeMarkersAndRoute();
  }

  void _initializeMarkersAndRoute() {
    for (var place in widget.dataList) {
      final lat = place['latitudeColumn'];
      final lng = place['longitudeColumn'];
      final placeName = place['placeName'] ?? 'Unnamed Place';

      // Create marker for each place
      LatLng position = LatLng(lat, lng);
      _markers.add(
        Marker(
          markerId: MarkerId(placeName),
          position: position,
          infoWindow: InfoWindow(title: placeName),
        ),
      );

      // Add position to route coordinates for polyline
      _routeCoordinates.add(position);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // Optional: Set the camera position to the first location
    if (_routeCoordinates.isNotEmpty) {
      mapController.moveCamera(
        CameraUpdate.newLatLngZoom(_routeCoordinates[0], 12),
      );
    }
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
          target: _routeCoordinates.isNotEmpty
              ? _routeCoordinates[0]
              : LatLng(37.7749, -122.4194), // Default position if empty
          zoom: 12,
        ),
        markers: _markers,
        polylines: {
          Polyline(
            polylineId: PolylineId("route"),
            points: _routeCoordinates,
            color: Colors.blue,
            width: 4,
          ),
        },
        mapType: MapType.normal,
      ),
    );
  }
}
