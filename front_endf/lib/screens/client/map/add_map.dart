import 'package:blogapp/screens/agence/add_offer.dart';
import 'package:blogapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddMap extends StatefulWidget {
  //const AddMap({Key? key}) : super(key: key);

  @override
  _AddMapState createState() => _AddMapState();
}

class _AddMapState extends State<AddMap> {
  static const _initialCameraPositon = CameraPosition(
    target: LatLng(28.033886, 1.659626),
    zoom: 4.5,
  );
  late GoogleMapController _googleMapController;
  List<Marker> markers = [];
  int id = 1;
  var _latLng;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F7F7),
      appBar: AppBar(
        backgroundColor: C_3,
        title: const Text(
          "Add Location",
          style: TextStyle(
            fontSize: 32.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onLongPress: (LatLng latLng) {
          Marker newMarker = Marker(
            markerId: MarkerId('$id'),
            position: LatLng(latLng.latitude, latLng.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
          );
          markers.add(newMarker);
          //id = id+1;
          _latLng = latLng;
          setState(() {});
        },
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPositon,
        onMapCreated: (controller) => _googleMapController = controller,
        markers: markers.map((e) => e).toSet(),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: C_3,
          foregroundColor: const Color(0xFFF2F7F7),
          child: const Icon(Icons.check),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => AddOfferView()),
                (route) => false);
          }),
    );
  }
}

//latLng
