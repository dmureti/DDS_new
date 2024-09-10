import 'dart:async';
import 'package:distributor/app/locator.dart';
import 'package:distributor/services/location_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:geocoding/geocoding.dart';

class MapViewmodel extends FutureViewModel<UserLocation> {
  LocationService _locationService = locator<LocationService>();
  DialogService _dialogService = locator<DialogService>();
  final Completer<GoogleMapController> _controller = Completer();
  final UserLocation _startLocation;
  final UserLocation _destinationLocation;
  final Customer _customer;
  Customer get customer => _customer;

  // Object for polyline objects
  // Initialize PolyLinePoints
  PolylinePoints _polylinePoints = PolylinePoints();

  // List of cooordinates to join
  List<LatLng> _polylineCoordinates = [];

  // Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> _polylines = {};

  Map<PolylineId, Polyline> get polylines => _polylines;

  /// Method for creating polylines.
  /// You have to pass the starting and destination positions;
  _createPolylines(UserLocation start, UserLocation destination) async {
    // Generating the list of coordinates to be used for drawing the polyline points
    PolylineResult result = await _polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyCN3HvfBMxMr8j9RK0nNSp3NO0i-7eirJ8',
        PointLatLng(start.latitude, start.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving);

    // Add the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Define an Id
    PolylineId id = PolylineId('poly');

    /// Initialize Polyline
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.pink,
        points: _polylineCoordinates,
        width: 3);

    //Add the polylines to the map
    _polylines[id] = polyline;
  }

  Set<Marker> _markers = {};
  Set<Marker> get markers {
    Marker m = Marker(
      markerId: MarkerId('${customer.name}'),
      position:
          LatLng(_destinationLocation.latitude, _destinationLocation.longitude),
      infoWindow: InfoWindow(
          title: customer.name,
          snippet:
              '${customer.customerLocation.longitude}, ${customer.customerLocation.longitude}'),
    );
    _markers.add(m);
    return _markers;
  }

  Completer<GoogleMapController> get controller => _controller;
  double get latitude => _destinationLocation.latitude;
  double get longitude => _destinationLocation.longitude;

  CameraPosition get initialPosition {
    return CameraPosition(
        target: LatLng(latitude, longitude),
//      zoom: 14.4746,
        zoom: 16);
  }

  init() async {
//    _markers[markerId] = marker;
//    await _createPolylines(_startLocation, _destinationLocation);
  }

  final MarkerId markerId = MarkerId("customermarker");
  Marker get marker => Marker(
      markerId: MarkerId(customer.name),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(title: customer.name, snippet: ''));

  MapViewmodel(
      {UserLocation start, UserLocation end, @required Customer customer})
      : _startLocation = start,
        _destinationLocation = end,
        _customer = customer,
        assert(customer != null);

  bool _showCustomerDetail;
  bool get showCustomerDetail {
    if (_showCustomerDetail == null) {
      _showCustomerDetail = true;
    } else {
      _showCustomerDetail = false;
    }
    return _showCustomerDetail;
  }

  @override
  Stream<UserLocation> get stream => _locationService.locationStream;

  /**
   * Get coordinates
   */
  getCoordinates(Customer customer) {
    UserLocation _customerLocation;
    if (customer.gpsLocation != null) {
      List<String> _coords = customer.gpsLocation.split(',');
      double latitude = double.tryParse(_coords[0]);
      double longitude = double.tryParse(_coords[1]);
      if (latitude != null && longitude != null) {
        _customerLocation =
            UserLocation(latitude: latitude, longitude: longitude);
        return _customerLocation;
      } else {
        return UserLocation(longitude: 0.0, latitude: 0.0);
      }
    }
  }

  getDistance(UserLocation startLocation, UserLocation finalLocation) async {
    double distance = await _locationService.getDistanceBetween(
        startLocation.latitude,
        startLocation.longitude,
        finalLocation.latitude,
        finalLocation.longitude);
    return distance;
  }

  UserLocation _currentPosition;
  UserLocation get currentPosition => _currentPosition;
  getCurrentPosition() async {
    var result = await _locationService.getLocation();
    if (result is UserLocation) {
      return _currentPosition;
    } else {
      await _dialogService.showDialog(
          title: 'Could not get location', description: result.toString());
    }
  }

  @override
  Future<UserLocation> futureToRun() async {
    await _createPolylines(_startLocation, _destinationLocation);
    UserLocation userLocation = await _locationService.getLocation();
    return userLocation;
  }

  Future<List<Placemark>> placemarkFromCoordinate(
      UserLocation userLocation) async {
    List<Placemark> placemark = await _locationService.placemarkFromCoordinates(
        userLocation.latitude, userLocation.longitude);
    return placemark;
  }
}
