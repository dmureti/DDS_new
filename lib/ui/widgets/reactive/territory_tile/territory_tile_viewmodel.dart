import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/services/location_repository.dart';
import 'package:distributor/services/user_service.dart';
import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class TerritoryTileViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _locationService = locator<LocationRepository>();
  final _dialogService = locator<DialogService>();
  final _userService = locator<UserService>();
  final Geolocator geolocator = Geolocator();

  Position _position;
  String _status = "UNKNOWN";

  Position get position => _position;
  String get status => _status;

  getCurrentPosition() async {
    setBusy(true);
    _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setBusy(false);
    notifyListeners();
  }

  setLocation() async {
    setBusy(true);
    await getCurrentPosition();
    setBusy(false);
    notifyListeners();
  }

  double _distanceBetween = 0;
  double get distanceBetween => _distanceBetween;

  getDistanceBetween() async {
    setBusy(true);
    double pointedLatitude = double.parse(fence.latitude);
    double pointedLongitude = double.parse(fence.longitude);
    _distanceBetween = await _locationService.getDistanceBetween(
      position.latitude,
      position.latitude,
      pointedLatitude,
      pointedLongitude,
    );
    setBusy(false);
    notifyListeners();
  }

  init() async {
    await setLocation();
    // await getDistanceBetween();
    // listenToGeofenceStream();
    await startGeofenceService();
  }

  final Fence fence;
  TerritoryTileViewModel(this.fence) {}

  startGeofenceService() async {
    // Start the geofence service
    EasyGeofencing.startGeofenceService(
        pointedLatitude: fence.latitude,
        pointedLongitude: fence.longitude,
        radiusMeter: fence.radius.toString(),
        eventPeriodInSeconds: 5);
  }

  navigateToTerritoryDetail(Fence fence) {
    _navigationService.navigateTo(Routes.territoryDetailView,
        arguments: TerritoryDetailViewArguments(fence: fence));
  }
}
