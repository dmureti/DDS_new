class DDSGeoPoint {
  dynamic vehicleId;
  dynamic journeyId;

  //Latitude, Longitude and geohash
  Map<String, dynamic> position;

  DDSGeoPoint();

  factory DDSGeoPoint.fromMap() {
    return DDSGeoPoint();
  }

  Map<String, dynamic> toJson() => {};
}
