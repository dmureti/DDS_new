import 'package:distributor/app/locator.dart';
import 'package:distributor/services/init_service.dart';
import 'package:stacked/stacked.dart';

class RememberMeViewModel extends BaseViewModel {
  InitService _initService = locator<InitService>();

  bool get rememberMe => _initService.rememberMe;

  Future toggleSavePassword(bool val) async {
    await _initService.toggleSavePassword(val);
    notifyListeners();
  }
}
