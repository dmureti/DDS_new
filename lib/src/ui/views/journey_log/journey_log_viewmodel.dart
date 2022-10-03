import 'package:distributor/app/locator.dart';
import 'package:distributor/services/waypoint_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class JourneyLogViewModel extends BaseViewModel {
  final _waypointService = locator<WaypointService>();

  GoogleMapController mapController;
  UserLocation _userLocation;
  CameraPosition _cameraPosition;
  double _zoom = 10;

  CameraPosition get cameraPosition => _cameraPosition;
  UserLocation get userLocation => _userLocation;
  double get zoom => _zoom;

  _getUserLocation() async {
    setBusy(true);
    _userLocation = await _waypointService.getCurrentLocation();
    setBusy(false);
    print(_userLocation.latitude);
  }

  setCameraPosition({double latitude, double longitude, double zoom}) {
    _cameraPosition =
        CameraPosition(target: LatLng(latitude, longitude), zoom: zoom);
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // notifyListeners();
  }

  init() async {
    await _getUserLocation();
    setCameraPosition(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
        zoom: zoom);
  }

  addMarker() {}

  fetchMarkers() async {}

  animateToUser() async {
    await _getUserLocation();
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(userLocation.latitude, userLocation.longitude),
        zoom: 17)));
    notifyListeners();
  }
}
