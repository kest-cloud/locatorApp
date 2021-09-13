class LocationModel {
  List coordinates;

  LocationModel({required this.coordinates});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      coordinates: json["coordinates"] as List,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "coordinates": coordinates,
    };
  }
}
