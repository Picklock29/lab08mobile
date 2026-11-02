import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/location_result.dart';

class MapPage extends StatelessWidget {
  final LocationResult locationResult;

  const MapPage({
    super.key,
    required this.locationResult,
  });

  @override
  Widget build(BuildContext context) {
    final currentPosition = LatLng(
      locationResult.latitude,
      locationResult.longitude,
    );

    const Color bgCanvas = Color(0xFFFBF9F5);
    const Color inkPrimary = Color(0xFF181F1B);
    const Color borderSubtle = Color(0xFFE8E4DD);

    return Scaffold(
      backgroundColor: bgCanvas,
      appBar: AppBar(
        backgroundColor: bgCanvas,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Center(
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: borderSubtle),
              ),
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.arrow_back, size: 18, color: inkPrimary),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
        title: const Text(
          'แผนที่ตำแหน่งปัจจุบัน',
          style: TextStyle(
            color: inkPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
          ),
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
          // TODO: กำหนด initialCenter เป็น currentPosition
          initialCenter: currentPosition,
          // TODO: กำหนดระดับการซูมที่เหมาะสม เช่น 16
          initialZoom: 16.0,
        ),
        children: [
          // TODO: เพิ่ม TileLayer ของ OpenStreetMap
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.my_location_explorer',
          ),
          // TODO: เพิ่ม MarkerLayer เพื่อแสดง Marker ที่ currentPosition (Marker สีแดง)
          MarkerLayer(
            markers: [
              Marker(
                point: currentPosition,
                width: 60,
                height: 60,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 45,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
