import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/core/enums.dart';
import 'package:distributor/services/activity_service.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/init_service.dart';
import 'package:distributor/services/location_repository.dart';
import 'package:distributor/services/timeout_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:distributor/services/version_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class LoginViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final snackBarService = locator<SnackbarService>();
  ActivityService _activityService = locator<ActivityService>();
  InitService _initService = locator<InitService>();
  TimeoutService _timerService = locator<TimeoutService>();
  final _versionService = locator<VersionService>();
  final locationService = locator<LocationRepository>();
  // final geofenceService = locator<GeoFenceService>();

  String get version => _versionService.version;

  List<AppEnv> get environments => _initService.availableEnvList;

  List<String> get languages => <String>[
        'English',
        'Swahili',
      ];

  String _language;
  String get language => _language ?? languages.first;
  setLanguage(String val) {
    _language = val;
    notifyListeners();
  }

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
      // Clear the cache
      await api.clearAPICache();
      // Update the user

      _userService.updateUser(result);
      //Initialize the timer
      _timerService.init();

      // Update the activity Service
      _activityService.addActivity(Activity(
          activityTitle: 'Login in', activityDesc: 'Logged In successfully'));
      // Start listening to location stream updates

      // Initialize the geofencing service

      if (result.status != 1) {
        _navigationService.pushNamedAndRemoveUntil(Routes.changePasswordView,
            arguments: ChangePasswordViewArguments(
                passwordChangeType: PasswordChangeType.initial));
      } else {
        // await initializeAppCache(result);
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

  bool _displayInitDialog = false;
  bool get displayInitDialog => _displayInitDialog;
  setDisplayInitDialog(bool value) {
    _displayInitDialog = value;
    notifyListeners();
  }

  initializeAppCache(User user) async {
    setDisplayInitDialog(true);
    snackBarService.showSnackbar(message: 'Preparing environment');
    await api.initializeAppCache(user);
    setDisplayInitDialog(false);
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

  // @override
  // Stream<GeofenceStatus> get stream => geofenceService.getGeofenceStream();
  //
  // get enableSignIn {
  //   switch (data) {
  //     case GeofenceStatus.init:
  //       return false;
  //     case GeofenceStatus.exit:
  //       return false;
  //     case GeofenceStatus.enter:
  //       return true;
  //   }
  // }
}
