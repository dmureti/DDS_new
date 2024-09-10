import 'package:distributor/app/locator.dart';
import 'package:distributor/services/location_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:geocoding/geocoding.dart';

class DeliveryJourneyMapViewModel extends FutureViewModel<UserLocation> {
  final _locationService = locator<LocationRepository>();

  init() async {}

  final DeliveryJourney _deliveryJourney;
  DeliveryJourney get deliveryJourney => _deliveryJourney;

  DeliveryJourneyMapViewModel(DeliveryJourney deliveryJourney)
      : _deliveryJourney = deliveryJourney;

  /// The current position of the user
  UserLocation _currentPosition;
  UserLocation get currentPosition => _currentPosition;

  /// Marker where user is
  Marker _userMarker;
  Marker get userMarker {
    _userMarker = Marker(
        markerId: MarkerId('$currentPosition'),
        position: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        infoWindow: InfoWindow(title: 'Your current location'),
        icon: BitmapDescriptor.defaultMarker);
    return _userMarker;
  }

  UserLocation _destinationCoordinates;
  UserLocation get destinationCoordinates => _destinationCoordinates;
  updateDestinationCoordinates(UserLocation val) {
    _destinationCoordinates = val;
    notifyListeners();
  }

  Marker _destinationMarker;
  Marker get destinationMarker {
    if (destinationMarker == null) {
      _destinationMarker = Marker(
          markerId: MarkerId('$destinationCoordinates'),
          position: LatLng(destinationCoordinates.latitude,
              destinationCoordinates.longitude),
          infoWindow: InfoWindow(title: 'Destination', snippet: 'Add address'),
          icon: BitmapDescriptor.defaultMarker);
    }
    return _destinationMarker;
  }

  addMarker(UserLocation userLocation) {
    Marker m = Marker(
        markerId: MarkerId('$userLocation'),
        position: LatLng(userLocation.latitude, userLocation.longitude),
        infoWindow: InfoWindow(
            title: 'Add customer name', snippet: 'Add customer address'),
        icon: BitmapDescriptor.defaultMarker);
    _markers.add(m);
  }

  Position _northEastCoordinates;
  Position _southwestCoordinates;

  String _currentAddress;
  String get currentAddress => _currentAddress;

  updateCurrentAddress(String val) {
    _currentAddress = val;
    notifyListeners();
  }

  String _startAddress = '';
  String _destinationAddress = '';
  String _placeDistance;

  Set<Marker> _markers = {};
  Set<Marker> get markers {
    if (_customers != null && _customers.length > 0) {
      _customers.map((e) {
        Marker m = Marker(
            markerId: MarkerId('${e.name}'),
            position: LatLng(
                e.customerLocation.latitude, e.customerLocation.longitude),
            infoWindow:
                InfoWindow(title: e.name, snippet: '${e.customerLocation}'),
            icon: BitmapDescriptor.defaultMarker);
        _markers.add(m);
      }).toList();
    }
    return _markers;
  }

  Map<PolylineId, Polyline> _polylines = {};
  List<LatLng> _polylineCoordinates = [];

  List<Customer> _customers = <Customer>[];
  List<Customer> get customers => _customers;
  updateCustomers(Customer customer) {
    _customers.add(customer);
  }

  getAddress(double latitude, double longitude) async {
    List<Placemark> p =
        await _locationService.placemarkFromCoordinates(latitude, longitude);
    Placemark place = p[0];
    _currentAddress =
        "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
    _startAddress = currentAddress;
    notifyListeners();
  }

  /// Get the current position of the user
  Future<UserLocation> getCurrentPosition() async {
    var result = await _locationService.getLocation();
    if (result is UserLocation) {
      _currentPosition = result;
      print(currentPosition.latitude);
      await getAddress(_currentPosition.latitude, _currentPosition.longitude);
      notifyListeners();
    }
    return result;
  }

  /// Initial location of the map view
  CameraPosition _initialLocation;
  CameraPosition get initialLocation {
    if (_initialLocation == null) {
      return CameraPosition(
          zoom: _zoom,
          target:
              LatLng(_currentPosition.latitude, _currentPosition.longitude));
    } else {
      return _initialLocation;
    }
  }

  double _zoom = 13.0;
  double get zoom => _zoom;

  ///
  bool _myLocationEnabled = true;
  bool get myLocationEnabled => _myLocationEnabled;

  /// For controlling the camera position of the map view
  GoogleMapController _mapController;
  GoogleMapController get mapController => _mapController;

  MapViewModel() {}

  onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  zoomIn() {
    _mapController.animateCamera(CameraUpdate.zoomIn());
    _zoom++;
    notifyListeners();
  }

  zoomOut() {
    _mapController.animateCamera(CameraUpdate.zoomOut());
    _zoom--;
    notifyListeners();
  }

  zoomTo() {}

  /// Move the camera to a new position
  moveCameraTo(double latitude, double longitude) async {
    await _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 18),
      ),
    );
    notifyListeners();
  }

  animateCameraToUser() {
    moveCameraTo(_currentPosition.latitude, _currentPosition.longitude);
  }

  @override
  Future<UserLocation> futureToRun() async {
    var result = await getCurrentPosition();
    return result;
  }
}
