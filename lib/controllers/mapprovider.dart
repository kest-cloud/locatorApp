import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:locator/helpers/googleapi.dart';
import 'package:locator/models/location_model.dart';
//import 'package:locator/services/location_service.dart';

class MapProvider extends ChangeNotifier {
  Address address = Address();
  bool loading = true;
  String message = '';
  List<LocationModel> locationmodel = [];

  TextEditingController controllerStoreId = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();

  // void addLocation() async {
  //   message = 'Location stored succesfully!';
  //   notifyListeners();
  //   print("StoreId: ${controllerStoreId.text}");
  //   print("Address: ${controllerAddress.text}");

  //   try {
  //     GoogleApi googleApi = GoogleApi();
  //     LocationModel locationModel = LocationModel(
  //       storeId: int.parse(controllerStoreId.text),
  //       address: controllerAddress

  //     var res = await googleApi.sendLocation(locationModel);
  //     print("location stored: $res");
  //     if (res != null) {
  //       message = "Location stored succesfully";
  //     }
  //   } catch (error) {
  //     message = "Error: $error";
  //     notifyListeners();
  //   }
  // }

  void sendLocationToDatabase() async {
    Random random = new Random();
    var numb = random.nextInt(8);
    message = 'Location stored successfully!';
    notifyListeners();
    try {
      GoogleApi googleApi = GoogleApi();
      LocationModel locationModel =
          LocationModel(address: "${address.addressLine}", storeId: numb);
      print("_address.addressLine");
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
