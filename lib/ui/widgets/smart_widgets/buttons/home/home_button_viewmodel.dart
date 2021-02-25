import 'package:distributor/app/locator.dart';
import 'package:distributor/services/access_controller_service.dart';
import 'package:stacked/stacked.dart';

class HomeButtonViewModel extends BaseViewModel {
  AccessControlService _accessControlService = locator<AccessControlService>();

  HomeButtonViewModel() {
    _isEnabled = false;
  }

  bool _isEnabled = false;
  bool get isEnabled => _isEnabled;

  checkPermissions() {
    var result = _accessControlService.enableJourneyTab;
    if (result is bool) {
      return result;
    } else {
      return false;
    }
  }

  init() {
    setBusy(true);
    _isEnabled = checkPermissions();
    setBusy(false);
    notifyListeners();
  }
}
