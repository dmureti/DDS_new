import 'package:distributor/app/locator.dart';
import 'package:distributor/services/location_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class DistanceWidgetViewModel extends FutureViewModel {
  final _locationService = locator<LocationRepository>();
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
