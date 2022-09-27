import 'package:distributor/app/locator.dart';
import 'package:distributor/services/location_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class LocationViewModel extends StreamViewModel<UserLocation> {
  final _locationService = locator<LocationRepository>();

  @override
  Stream<UserLocation> get stream => _locationService.locationStream;
}
