import 'package:distributor/app/locator.dart';
import 'package:distributor/services/init_service.dart';
import 'package:stacked/stacked.dart';

class RememberMeViewModel extends BaseViewModel {
  InitService _initService = locator<InitService>();

  init() async {
    _rememberMe = _initService.rememberMe;
  }

  bool _rememberMe;
  bool get rememberMe => _rememberMe;

  Future toggleSavePassword(bool val) async {
    _rememberMe = !rememberMe;
    await _initService.toggleSavePassword(val);
    notifyListeners();
  }
}
