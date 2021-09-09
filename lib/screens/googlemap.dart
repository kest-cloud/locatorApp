import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({Key? key}) : super(key: key);

  @override
  _AddLocationPageState createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  //Set<Marker> _markers = {};

  late GoogleMapController _controller;

  final List<Marker> markers = [];

  addMarker(cordinate) {
    int id = Random().nextInt(100);
    setState(() {
      markers
          .add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
    });
  }

  // void _onMapcreated(GoogleMapController controller) {
  //   setState(() {
  //     _markers.add(Marker(
  //         markerId: MarkerId('id-1'),
  //         position: LatLng(22.544131, 88.340369),
  //         infoWindow: InfoWindow(title: "Victoria Island")));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Google Map'),
        ),
        body: GoogleMap(
          mapType: MapType.normal,
          onMapCreated: (controller) {
            setState(() {
              _controller = controller;
            });
          },
          onTap: (cordinate) {
            _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
            addMarker(cordinate);
            print(cordinate);
          },
          markers: markers.toSet(),
          initialCameraPosition: CameraPosition(
            target: LatLng(22.5448131, 88.3403691),
            zoom: 15,
          ),
        ));
  }
}
