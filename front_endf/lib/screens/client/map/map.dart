import 'package:blogapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLocation extends StatefulWidget {
  const MapLocation({Key? key}) : super(key: key);

  @override
  _MapLocationState createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  static const _initialCameraPositon = CameraPosition(
    target: LatLng(28.033886, 1.659626),
    zoom: 4.5,
  );

  late GoogleMapController _googleMapController;
  List<Marker> markers = [];
  List<Marker> _list = [
    Marker(
      markerId: MarkerId('Algeirs'),
      position: LatLng(36.749578, 3.080537),
      infoWindow: InfoWindow(title: 'Algiers house'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueBlue,
      ),
    ),
    Marker(
      markerId: MarkerId('Annaba'),
      position: LatLng(36.916909, 7.767537),
      infoWindow: InfoWindow(title: 'Annaba house'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueBlue,
      ),
    ),
    Marker(
      markerId: MarkerId('Oran'),
      position: LatLng(35.714681, -0.620977),
      infoWindow: InfoWindow(title: 'Oran house'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueBlue,
      ),
    ),
    Marker(
      markerId: MarkerId('Djelfa'),
      position: LatLng(34.552345, 2.73774),
      infoWindow: InfoWindow(title: 'Djelfa house'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueBlue,
      ),
    ),
    Marker(
      markerId: MarkerId('Setif'),
      position: LatLng(36.18403, 5.417031),
      infoWindow: InfoWindow(title: 'Setif house'),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueBlue,
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    markers.addAll(_list);
  }

  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF04027C),
        title: const Text(
          "Map",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 32.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 60,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPositon,
        onMapCreated: (controller) => _googleMapController = controller,
        markers: Set<Marker>.of(markers),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: C_3,
        foregroundColor: const Color(0xFFF2F7F7),
        onPressed: () => _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(_initialCameraPositon),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
