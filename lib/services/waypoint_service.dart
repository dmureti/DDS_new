import 'package:distributor/app/locator.dart';
import 'package:distributor/services/firestore_service.dart';
import 'package:distributor/services/journey_service.dart';
import 'package:distributor/services/location_repository.dart';
import 'package:distributor/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:geoflutterfire/src/geoflutterfire.dart';

class WaypointService {
  final _locationService = locator<LocationRepository>();
  final _journeyService = locator<JourneyService>();
  final _firestoreService = locator<FirestoreService>();
  final _userService = locator<UserService>();
  Geoflutterfire geo = Geoflutterfire();

  bool get hasJourney => _journeyService.hasJourney;

  DeliveryJourney get currentJourney => _journeyService.currentJourney;

  getCurrentLocation() async {
    return await _locationService.getLocation();
  }

  addMarker(
      {@required LatLng position,
      String title = "",
      String snippet = ""}) async {
    var marker = Marker(
        position: position,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: title, snippet: snippet));
    return Marker;
  }

  createWayPoint(LatLng latLng,
      {bool isEvent = false,
      String title = "",
      String description = ""}) async {
    GeoFirePoint point =
        geo.point(latitude: latLng.latitude, longitude: latLng.longitude);
    Map<String, dynamic> data = {
      "position": point,
      "journeyId": currentJourney.journeyId,
      "creationDate": DateTime.now().toIso8601String(),
      "title": title,
      "description": description,
      "isEvent": isEvent
    };

    await _firestoreService.createGeoPoint(data, currentJourney.journeyId);
  }

  fetchAll() async {
    var result = await _firestoreService.fetchMarkers(currentJourney.journeyId);
    return result;
  }

  fetchWayPointById(String id) async {}
  updateWayPoint(String id, Map<String, dynamic> data) async {}

  initializeJourney() async {
    Map<String, dynamic> data = {
      "startTime": DateTime.now().toIso8601String(),
      "journeyId": currentJourney.journeyId,
      "route": currentJourney.route,
      "status": "In Transit",
      "waypoints": [],
      "userId": _userService.user.id,
      "duration": 0,
      "distance": 0
    };
    await _firestoreService.updateJourney(currentJourney.journeyId, data);
    //Start the location stream
  }

  completeJourney() async {
    Map<String, dynamic> data = {
      "endTime": DateTime.now().toIso8601String(),
      "status": "Complete",
    };
    await _firestoreService.updateJourney(currentJourney.journeyId, data);
    return true;
  }

  listenToLocation() {
    List<UserLocation> updatedLocations = [];
    _locationService.locationStream.listen((UserLocation userLocation) {
      print("${userLocation.latitude} ${userLocation.longitude}");
      if (userLocation != null) {
        updatedLocations.add(userLocation);
        createWayPoint(LatLng(userLocation.latitude, userLocation.longitude));
        //Add the waypoint to the database
        // print("${userLocation.latitude} ${userLocation.longitude}");
      }
    });
  }
}
