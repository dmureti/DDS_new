import 'package:distributor/app/locator.dart';
import 'package:distributor/services/location_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:geocoding/geocoding.dart';

class PlacemarkWidgetViewModel extends FutureViewModel<List<Placemark>> {
  final _locationService = locator<LocationRepository>();
  final UserLocation _userLocation;

  PlacemarkWidgetViewModel(this._userLocation);

  List<Placemark> _placeMark;
  List<Placemark> get placeMark => _placeMark;

  @override
  Future<List<Placemark>> futureToRun() async {
    var result = await _locationService.placemarkFromCoordinates(
        _userLocation.latitude, _userLocation.longitude);
    return result;
  }
}
