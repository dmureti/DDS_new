import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/core/enums.dart';
import 'package:distributor/services/activity_service.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:distributor/services/version_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:distributor/services/init_service.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  ActivityService _activityService = locator<ActivityService>();
  InitService _initService = locator<InitService>();
  final _versionService = locator<VersionService>();

  String get version => _versionService.version;

  List<AppEnv> get environments => _initService.availableEnvList;

  LoginViewModel(String userId, String password)
      : _userId = userId,
        _password = password;

  init() async {
    _rememberMe = _initService.rememberMe;
  }

  bool _rememberMe;
  bool get rememberMe => _rememberMe;

  toggleSavePassword(bool val) async {
    _rememberMe = !rememberMe;
    await _initService.toggleSavePassword(val);
    notifyListeners();
  }

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
    var result;
    if (rememberMe) {
      await _initService.saveUserCredentials(
          userId: userId, password: password);
    }

    result = await authenticationService.loginWithUserIdAndPassword(
        userId: userId, password: password);
    setBusy(false);
    if (result is User) {
      // Update the user

      _userService.updateUser(result);

      // Update the activity Service
      _activityService.addActivity(Activity(
          activityTitle: 'Login in', activityDesc: 'Logged In successfully'));

      if (result.status != 1) {
        _navigationService.pushNamedAndRemoveUntil(Routes.changePasswordView,
            arguments: ChangePasswordViewArguments(
                passwordChangeType: PasswordChangeType.initial));
      } else {
        //@TODO Check if the user has accepted location permissions
        //If NOT display dialog
        // await _dialogService.showDialog(
        //     title: '',
        //     description:
        //         'DDS collects location data to enable verification of deliveries at the respective client destinations even when the app is closed or not in use.”');

        //Navigate to the home page
        _navigationService.pushNamedAndRemoveUntil(Routes.homeView);
      }
    } else if (result is CustomException) {
      await _dialogService.showDialog(
          title: 'Login Failure', description: result.description);
    } else {
      await _dialogService.showDialog(
          title: 'Login Failure', description: 'Unknown Error.');
    }
  }

  void updatePassword(String value) {
    if (value.isNotEmpty) {
      _password = value.trim();
      notifyListeners();
    }
  }

  void navigateToForgotPassword() async {
    await _navigationService.navigateTo(Routes.resetPasswordView);
  }

  String _userId;
  String get userId => _userId;
  setUserId(String val) {
    if (val.isNotEmpty) {
      _userId = val.trim();
    }
  }
}
