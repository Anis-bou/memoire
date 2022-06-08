import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

class mapbox extends StatefulWidget {
  const mapbox({Key? key}) : super(key: key);

  @override
  State<mapbox> createState() => _mapboxState();
}

class _mapboxState extends State<mapbox> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: latLng.LatLng(36.8149422118943, 5.763239943702752),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            additionalOptions: {
              'accesstoken':
                  'https://api.mapbox.com/styles/v1/anisdz/cl3d08dfe001s14ny885qqb84/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYW5pc2R6IiwiYSI6ImNsM2QyOGlxeTAzc3gzZG5seWQ4ZHgwZGcifQ.qYGFpf7jpqDkwkyDow4wTg',
              'id': 'mapbox.satellite'
            }
            //subdomains: ['a', 'b', 'c'],
            /* attributionBuilder: (_) {
            return Text("© OpenStreetMap contributors");
          },*/
            ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: latLng.LatLng(36.8149422118943, 5.763239943702752),
              builder: (ctx) => Container(
                child: Icon(Icons.place),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
