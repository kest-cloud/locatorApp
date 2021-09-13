import 'dart:async';
import 'package:flutter/material.dart';
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
  MapProvider _mapProvider = MapProvider();

  @override
  void initState() {
    super.initState();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    _streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        print(position.longitude);
        _position = position;
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
                    Text("Location  lon:${_position.longitude}"),
                    SizedBox(height: 20.0),
                    Text("Location  lat:${_position.latitude}"),
                    SizedBox(height: 20.0),
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
}
