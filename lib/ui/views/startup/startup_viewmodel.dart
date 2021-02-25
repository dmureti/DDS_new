import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/services/init_service.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class StartupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final InitService _initService = locator<InitService>();

  AppEnv get appEnv => _initService.appEnv;

  Future handleStartUpLogic() async {
    bool result = await _initService.init();
    if (!result) {
      _navigationService.navigateTo(Routes.loginViewRoute);
    } else {
      bool result = await _initService.fetchUserCredentials();
      if (result) {
        _navigationService.navigateTo(Routes.loginViewRoute);
      }
    }
  }

  // List of environments
  List<AppEnv> get availableEnvList => _initService.availableEnvList;

  updateEnv(AppEnv appEnv) {
    _initService.updateAppEnv(appEnv);
    notifyListeners();
  }
}
