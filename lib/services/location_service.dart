import 'dart:async';

import 'package:distributor/app/locator.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/location_repository.dart';
import 'package:distributor/services/remote_storage_repository.dart';
import 'package:distributor/services/user_service.dart';
import 'package:distributor/core/models/waypoint.dart';

import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geoflutterfire/src/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tripletriocore/src/core/models/user_location.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:geocoding/geocoding.dart';

class LocationService implements LocationRepository {
  Geoflutterfire geo = Geoflutterfire();
  final _api = locator<ApiService>();
  final remoteStorageService = locator<RemoteStorageRepository>();

  Api get api => _api.api;

  /// Keep track of current location
  UserLocation _currentLocation;

  /// Continuously emit location updates
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  LocationService() {
    print('in location service');
    // listenToUserLocation();
    // listenToLocationUpdates();
    print('outside listenToUserLocationChange');

    // LocationOptions locationOptions =
    //     LocationOptions(accuracy: LocationAccuracy.low, distanceFilter: 200);
    // Geolocator().checkGeolocationPermissionStatus().then((granted) {
    //   if (granted == GeolocationStatus.granted) {
    //     Geolocator().getPositionStream(locationOptions).listen((position) {
    //       if (position != null) {
    //         _locationController.add(UserLocation(
    //             latitude: position.latitude, longitude: position.longitude));
    //         GeoFirePoint point = geo.point(
    //             latitude: position.latitude, longitude: position.longitude);
    //         Map<String, dynamic> locationData = {
    //           'position': point.data,
    //         };
    //         print("${position.latitude} ${position.longitude}");
    //         // remoteStorageService.writeLocationData(locationData);
    //       } else {
    //         print('fala');
    //       }
    //     });
    //   }
    // });
  }

  Stream<UserLocation> get locationStream => _locationController.stream;

  Future<UserLocation> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      _currentLocation = UserLocation(
          latitude: position.latitude, longitude: position.longitude);
      return _currentLocation;
    } catch (e) {
      return e;
    }
  }

  Future placemarkFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemark =
          await placemarkFromCoordinates(latitude, longitude);
      return placemark;
    } catch (e) {
      return e.toString();
    }
  }

  Future<double> getDistanceBetween(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) async {
    double distanceInMeters = await Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
    return distanceInMeters / 1000;
  }

  @override
  addGeoPoint() async {
    var pos = await getLocation();
    GeoFirePoint point =
        geo.point(latitude: pos.latitude, longitude: pos.longitude);
    Map<String, dynamic> locationData = {
      'position': point.data,
    };
    return await remoteStorageService.writeLocationData(locationData);
  }

  listenToUserLocation() {
    List waypoints = [];
    // LocationOptions locationOptions = LocationOptions(
    //     accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 1000);
    Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    ).listen((Position position) {
      if (position != null) {
        waypoints.add(UserLocation(
            latitude: position.latitude, longitude: position.longitude));
        _locationController.add(UserLocation(
            latitude: position.latitude, longitude: position.longitude));
        print("${position.latitude} : ${position.longitude}");
      }
      print('position null');
    }).onData((position) {
      if (position != null) {
        print("${position.latitude} : ${position.longitude}");
        waypoints.add(UserLocation(
            latitude: position.latitude, longitude: position.longitude));
        _locationController.add(UserLocation(
            latitude: position.latitude, longitude: position.longitude));
      }
    });
  }

  // This service depends on a journey
  listenToLocationUpdates(String token,
      {String journeyId = "JN-22-000062", String plateNum = "KDB 240L"}) {
    print('listening to location updates');
    Geolocator.getPositionStream(
      distanceFilter: 100,
    ).listen((Position position) {
      if (position != null) {
        //Add this waypoint to the database

        Waypoint wayPoint = Waypoint(
            latitude: position.latitude,
            longitude: position.longitude,
            speed: position.speed,
            journeyId: journeyId,
            plateNum: plateNum);

        api.createWaypoint(token: token, waypointData: wayPoint.toJson());
      }
      print(position == null
          ? 'Unknown'
          : '${position.latitude.toString()}, ${position.longitude.toString()} ${position.speed.toString()} -- updated');
    });
  }
}
