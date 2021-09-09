import 'dart:async';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geocoder/geocoder.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geocoder/model.dart';
//import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locator/controllers/mapprovider.dart';
import 'package:provider/provider.dart';

class Locations extends StatefulWidget {
  const Locations({Key? key}) : super(key: key);

  @override
  _LocationsState createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  late Position _position;
  late StreamSubscription<Position> _streamSubscription;
  Address _address = Address();
  MapProvider _mapProvider = MapProvider();

  @override
  void initState() {
    super.initState();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    _streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        print(position);
        _position = position;

        final coordinates =
            new Coordinates(position.latitude, position.longitude);
        convertCoordinatesToAddress(coordinates)
            .then((value) => _address = value);
        // var addr = _address;
        _mapProvider.sendLocationToDatabase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Location"),
        ),
        body: ChangeNotifierProvider(
          create: (context) => MapProvider(),
          builder: (context, child) {
            return Consumer<MapProvider>(builder: (context, value, child) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: 20.0),
                    Text("${value.message}"),
                    SizedBox(height: 30.0),
                    Text(
                        "Location lat:${_position.latitude}, lon:${_position.longitude}"),
                    SizedBox(height: 20.0),
                    Text("Address from Coordinates: "),
                    SizedBox(height: 20.0),
                    Text("${_address.addressLine}"),
                  ],
                ),
              );
            });
          },
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  Future<Address> convertCoordinatesToAddress(Coordinates coordinates) async {
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return addresses.first;
  }
}
