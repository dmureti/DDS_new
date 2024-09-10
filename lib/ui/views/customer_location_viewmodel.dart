import 'package:distributor/app/locator.dart';
import 'package:distributor/services/location_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:geocoding/geocoding.dart';

class CustomerLocationViewModel extends FutureViewModel {
  final _locationService = locator<LocationRepository>();
  DialogService _dialogService = locator<DialogService>();
  final UserLocation _customerLocation;

  CustomerLocationViewModel(this._customerLocation);

  UserLocation _userLocation;
  UserLocation get userLocation => _userLocation;

  String _currentAddress;
  String get currentAddress => _currentAddress;

  String _destinationAddress;
  String get destinationAddress => _destinationAddress;

  init() async {
    bool result = false;
    _userLocation = await _locationService.getLocation();
    _currentAddress = await _getAddress(_userLocation);
    _destinationAddress = await _getAddress(_customerLocation);
    return result;
  }

  _getAddress(UserLocation userLocation) async {
    try {
      List<Placemark> p = await _locationService.placemarkFromCoordinates(
          userLocation.latitude, userLocation.longitude);
      //Most probable result
      Placemark place = p[0];
      String address =
          "${place.name},${place.locality},${place.postalCode}, ${place.country}";
      return address;
    } catch (e) {
      await _dialogService.showDialog(
          title: 'Could not fetch address', description: e.toString());
    }
  }

  @override
  Future futureToRun() async {
    bool result = await init();
    return result;
  }
}
