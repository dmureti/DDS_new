import 'package:distributor/services/location_service.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:injectable/injectable.dart';

abstract class LocationRepository {
  @factoryMethod
  factory LocationRepository() => LocationService();

  get locationStream => null;
  getLocation();

  placemarkFromCoordinates(double latitude, double longitude);

  getDistanceBetween(
      double latitude, double longitude, double latitude2, double longitude2);

  addGeoPoint();

  listenToUserLocation() {}

  void listenToLocationUpdates(String token,
      {String journeyId, String plateNum}) {}
}
