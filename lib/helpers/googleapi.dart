import 'dart:convert';

import 'package:locator/models/location_model.dart';
import 'package:http/http.dart' as http;

class GoogleApi {
  String url = "http://10.0.2.2:5000/api/v1";

  Future<List<LocationModel>> findAll() async {
    var response = await http.get(Uri.parse('$url/stores'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      return body.map((stores) => LocationModel.fromJson(stores)).toList();
      // return body.fromJson(jsonDecode(response.body));
      //return body.map((posts) => Post.fromJson(posts));
    } else {
      throw Exception("Failed to Get locations");
    }
  }

  Future sendLocation(LocationModel locationModel) async {
    final response = await http.post(
      Uri.parse('$url/stores'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(locationModel.toJson()),
    );
    print(response.body);
    if (response.statusCode == 201) {
      return response.body;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      print(response.statusCode);
      throw Exception('Failed to send Address.');
    }
  }
}
