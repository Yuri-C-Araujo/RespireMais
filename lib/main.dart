import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // <--- IMPORTANTE: Adicione este import
import 'google_maps.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleMapsPage(
        latLong: LatLng(-9.62, -36.77),
      )
  ));
}