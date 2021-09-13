import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locator/helpers/googleapi.dart';
import 'package:locator/models/location_model.dart';

class MapProvider extends ChangeNotifier {
  late Position _position;
  bool loading = true;
  String message = '';
  List<LocationModel> locationmodel = [];

  void sendLocationToDatabase() async {
    message = 'Location stored successfully!';
    notifyListeners();
    try {
      GoogleApi googleApi = GoogleApi();
      LocationModel locationModel =
          LocationModel(coordinates: [_position.longitude, _position.latitude]);

      // print("${_position.longitude}");
      //print("${_position.latitude}");

      var result = await googleApi.sendLocation(locationModel);
      print("location stored: $result");
    } catch (error) {
      message = "Error: $error";
      notifyListeners();
    }
  }

  MapProvider() {
    sendLocationToDatabase();
  }
}
