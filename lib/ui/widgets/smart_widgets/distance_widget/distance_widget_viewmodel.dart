import 'package:distributor/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class DistanceWidgetViewModel extends FutureViewModel {
  LocationService _locationService = locator<LocationService>();
  final UserLocation _customerLocation;
  final UserLocation _userLocation;

  DistanceWidgetViewModel(this._customerLocation, this._userLocation);

  Future getDistance() async {
    _distance = await _locationService.getDistanceBetween(
        _customerLocation.latitude,
        _customerLocation.longitude,
        _userLocation.latitude,
        _userLocation.longitude);
    return _distance;
  }

  num _distance;

  @override
  Future futureToRun() async {
    return await getDistance();
  }
}
