import 'package:distributor/app/locator.dart';
import 'package:distributor/services/init_service.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class EnvironmentSelectionDropDownViewModel extends BaseViewModel {
  InitService _initService = locator<InitService>();
  AppEnv get appEnv => _initService.appEnv;
  List<AppEnv> get availableEnvList => _initService.availableEnvList;

  updateEnv(appEnv) {
    _initService.updateAppEnv(appEnv);
    notifyListeners();
  }
}
