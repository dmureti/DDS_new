import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/services/activity_service.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:distributor/services/init_service.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  ActivityService _activityService = locator<ActivityService>();
  InitService _initService = locator<InitService>();

  List<AppEnv> get environments => _initService.availableEnvList;

  updateEnv(AppEnv val) {
    _initService.updateAppEnv(val);
    notifyListeners();
  }

  AppEnv get _appEnv => _initService.appEnv;
  AppEnv get appEnv => _appEnv;

  final ApiService _apiService = locator<ApiService>();
  final DialogService _dialogService = locator<DialogService>();
  final UserService _userService = locator<UserService>();

  AuthenticationService get authenticationService => AuthenticationService(api);
  Api get api => _apiService.api;

  String _versionName;
  String get versionName => _versionName;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;
  toggleObscurePassword() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  String _emailValidationMessage;
  String get emailValidationMessage => _emailValidationMessage;

  String _passwordValidationMessage;
  String get passwordValidationMessage => _passwordValidationMessage;

  String _password;
  String get password => _password;

  login() async {
    setBusy(true);
    var result = await authenticationService.loginWithEmailAndPassword(
        email: _email.trim(), password: _password.trim());
    setBusy(false);
    if (result is User) {
      // Update the user
      _userService.updateUser(result);
      // Update the activity Service
      _activityService.addActivity(Activity(
          activityTitle: 'Login in', activityDesc: 'Logged In successfully'));
      //Navigate to the home page
      _navigationService.pushNamedAndRemoveUntil(Routes.homeViewRoute);
    } else if (result is CustomException) {
      await _dialogService.showDialog(
          title: 'Login Failure', description: result.description);
    } else {
      await _dialogService.showDialog(
          title: 'Login Failure', description: 'Unknown Error.');
    }
  }

  String _email;
  String get email => _email;
  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    notifyListeners();
  }

  void navigateToForgotPassword() async {
    await _navigationService.navigateTo(Routes.homeViewRoute);
  }
}
