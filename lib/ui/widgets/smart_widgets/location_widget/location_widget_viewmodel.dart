import 'package:distributor/app/locator.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class LocationViewModel extends StreamViewModel<UserLocation> {
  LocationService _locationService = locator<LocationService>();

  @override
  Stream<UserLocation> get stream => _locationService.locationStream;
}
