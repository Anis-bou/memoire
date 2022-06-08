import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindFriends extends StatefulWidget {
  const FindFriends({Key? key}) : super(key: key);

  @override
  _FindFriendsState createState() => _FindFriendsState();
}

class _FindFriendsState extends State<FindFriends> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(36.8149422118943, 5.763239943702752),
    zoom: 14.4746,
  );

  Set<Marker> _markers = {};

  GoogleMapController? _controller;

  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  List<dynamic> _contacts = [
    {
      "name": "1",
      "position": LatLng(36.84344934791479, 7.738472983985598),
    },
    {
      "name": "2",
      "position": LatLng(36.43085481121881, 3.2175183415948023),
    },
    {
      "name": "3",
      "position": LatLng(36.71849356519414, 3.0726468564515064),
    },
    {
      "name": "4",
      "position": LatLng(36.80692165350072, 5.754612421402309),
    },
    {
      "name": "5",
      "position": LatLng(36.30982642355503, 6.603995248260577),
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    createMarkers(context);
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
            initialCameraPosition: _kGooglePlex,
            markers: _markers,
            myLocationButtonEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
              _customInfoWindowController.googleMapController = controller;
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            onTap: (LatLng latLng) {
              _customInfoWindowController.hideInfoWindow!();
            }),
        CustomInfoWindow(
          controller: _customInfoWindowController,
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 0.8,
          offset: 60.0,
        ),
      ],
    ));
  }

  createMarkers(BuildContext context) {
    Marker marker;
    _contacts.forEach((contact) async {
      marker = Marker(
        markerId: MarkerId(contact['name']),
        position: contact['position'],
        //icon: await _getAssetIcon(context, contact['marker']).then((value) => value),
        infoWindow: InfoWindow(
            //title: contact['name'],
            //snippet: contact['descripton'],
            ),
      );

      setState(() {
        _markers.add(marker);
      });
    });
  }

  Future<BitmapDescriptor> _getAssetIcon(
      BuildContext context, String icon) async {
    final Completer<BitmapDescriptor> bitmapIcon =
        Completer<BitmapDescriptor>();
    final ImageConfiguration config =
        createLocalImageConfiguration(context, size: Size(5, 5));

    AssetImage(icon)
        .resolve(config)
        .addListener(ImageStreamListener((ImageInfo image, bool sync) async {
      final ByteData? bytes =
          await image.image.toByteData(format: ImageByteFormat.png);
      final BitmapDescriptor bitmap =
          BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
      bitmapIcon.complete(bitmap);
    }));

    return await bitmapIcon.future;
  }
}
