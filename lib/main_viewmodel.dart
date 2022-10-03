import 'package:distributor/app/locator.dart';
import 'package:distributor/services/location_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

//@TODO Convert to MultipleStreamViewModel
class MainViewModel extends BaseViewModel {
  final _locationService = locator<LocationRepository>();
  final _dialogService = locator<DialogService>();

  List<UserLocation> _waypoints = <UserLocation>[];
  List<UserLocation> get waypoints => _waypoints;

  init() {
    //@TODO Check the permissions for location
    //@TODO Initialize the location stream
    // listenToLocation();
  }

  listenToLocation() {
    List<UserLocation> updatedLocations = [];
    _locationService.locationStream.listen((UserLocation userLocation) {
      print("${userLocation.latitude} ${userLocation.longitude}");
      if (userLocation != null) {
        updatedLocations.add(userLocation);
        notifyListeners();
        // print("${userLocation.latitude} ${userLocation.longitude}");
      }
    });
  }
}
