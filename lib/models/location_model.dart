class LocationModel {
  int storeId;
  String address;

  LocationModel({required this.storeId, required this.address});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      storeId: json["storeId"] as int,
      address: json["address"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "storeId": storeId,
      "address": address,
    };
  }
}
