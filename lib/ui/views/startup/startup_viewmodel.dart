import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/init_service.dart';
import 'package:distributor/services/user_service.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class StartupViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final InitService _initService = locator<InitService>();
  UserService _userService = locator<UserService>();
  AuthenticationService get authenticationService => AuthenticationService(api);
  final ApiService _apiService = locator<ApiService>();
  Api get api => _apiService.api;

  AppEnv get appEnv => _initService.appEnv;

  login(String email, String password) async {
    var result = await authenticationService.loginWithEmailAndPassword(
        email: email.trim(), password: password);
    if (result is User) {
      _userService.updateUser(result);
      _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
    } else {
      _navigationService.navigateTo(Routes.loginView,
          arguments: LoginViewArguments(email: email, password: password));
    }
  }

  Future handleStartUpLogic() async {
    bool result = await _initService.init();
    String email;
    String password;
    if (!result) {
      email = "";
      password = "";
      _navigationService.navigateTo(Routes.loginView,
          arguments: LoginViewArguments(email: email, password: password));
    } else {
      if (result) {
        email = _initService.email ?? "";
        password = _initService.password ?? "";
        // login(email, password);a
        _navigationService.navigateTo(Routes.loginView,
            arguments: LoginViewArguments(email: email, password: password));
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
