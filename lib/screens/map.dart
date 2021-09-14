import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locator/cubit/location_cubit.dart';
import 'package:locator/cubit/location_state.dart';

import 'package:locator/screens/googlemap.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  late LocationCubit locationCubit = LocationCubit();
  late Position _position;
  late StreamSubscription<Position> _streamSubscription;

  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
  }

  void sendGeoData() {
    locationCubit..sendLocationMethod(_position);
  }

  @override
  void initState() {
    super.initState();
    var locationOptions = LocationOptions(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    _streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        print(position.longitude);
        print(position.latitude);
        _position = position;
        //_geoData = position;
        sendGeoData();

        //  _mapProvider.sendLocationToDatabase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Locator Storage"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Text("Google Map"),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              sendGeoData();
              // _getCurrentLocation();
            },
            child: Text("Get Current Location"),
          ),
          BlocProvider<LocationCubit>(
            create: (context) => locationCubit,
            child: BlocBuilder<LocationCubit, LocationState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return CircularProgressIndicator();
                } else if (state is ErrorState) {
                  return Text("${state.error.toString()}");
                } else if (state is SuccessState) {
                  return Text("${state.isSuccessful.toString()}");
                }
                return Text("Location Loading...");
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddLocationPage(),
              ));
        },
        tooltip: 'Google Map',
        child: Icon(Icons.pin_drop_outlined),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }
}
