import 'package:distributor/app/locator.dart';
import 'package:distributor/services/location_repository.dart';
import 'package:distributor/services/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class LocationStatusViewModel extends BaseViewModel {
  final _locationService = locator<LocationRepository>();
  final _dialogService = locator<DialogService>();
  final _permissionService = locator<PermissionService>();

  init() async {
    await getLocationStatus();
  }

  bool _isLocationActive;
  bool get isLocationActive => _isLocationActive;

  getLocationStatus() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      await openAppSettings();
    }
    if (await Permission.location.isRestricted) {}

    if (await Permission.locationWhenInUse.serviceStatus.isDisabled) {}
  }

  requestPermission() {}

  openAppSettings() async {
    if (await Permission.speech.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      openAppSettings();
    }
  }

  displayDialog() async {
    return await _dialogService.showDialog(
        title: 'Location ', description: 'Your location is turned off');
  }
}
