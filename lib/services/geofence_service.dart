import 'dart:async';

import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GeoFenceService {
  bool _disableServices = false;
  bool get disableServices => _disableServices;

  List _dependentServices;
  List get dependentServices => _dependentServices;

  GeofenceStatus _geofenceStatus;
  GeofenceStatus get geofenceStatus => _geofenceStatus;

  //  /
  /// [_streamSubscription] is for getting stream geofenceStatus updates on geofence updates
  ///
  static StreamSubscription<GeofenceStatus> _streamSubscription;

  ///
  /// [_streamController] is Stream controller for geofence event stream
  ///
  static StreamController<GeofenceStatus> _streamController =
      StreamController<GeofenceStatus>.broadcast();

  ///
  /// For [getting geofence status event stream] property which is basically returns [_geofenceStatusStream]
  ///
  Stream<GeofenceStatus> getGeofenceStream() {
    return _geofenceStatusStream;
  }

  ///
  /// [_geofenceStatusStream] is for geofenceStatus event stream
  ///
  static Stream<GeofenceStatus> _geofenceStatusStream;

  listenToGeofenceStatusStream() {
    _geofenceStatusStream = _streamController.stream;
    _streamSubscription =
        EasyGeofencing.getGeofenceStream().listen((GeofenceStatus status) {
      if (status != null) {
        _geofenceStatus = status;
        _streamController.add(status);
      }
      handleGeofenceStatus(status);
    });
  }

  GeoFenceService() {
    //Initialize the service
    EasyGeofencing.startGeofenceService(
        pointedLatitude: "-1.4230",
        pointedLongitude: "36.6972",
        radiusMeter: "250",
        eventPeriodInSeconds: 5);
  }

  static handleGeofenceStatus(GeofenceStatus status) {
    switch (status) {
      case GeofenceStatus.init:
        print('initializing');
        break;
      case GeofenceStatus.enter:
        print('Within Bounds');
        break;
      case GeofenceStatus.exit:
        print('Outside bounds');
        break;
    }
  }

  //Stop Stream service
  static stopGeofenceService() {
    EasyGeofencing.stopGeofenceService();
    // _geofenceController.close();
    _streamSubscription?.cancel();
  }

  //Cancel the subscription
  static cancelSubscription() {
    _streamSubscription?.cancel();
  }
}
