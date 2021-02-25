import 'package:shared_preferences/shared_preferences.dart';
import 'package:tripletriocore/tripletriocore.dart';

// Will handle necessary views as the app loads
class StartUpViewModel extends BaseModel {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences prefs;

  bool _rememberMe = false;

  String _email = "";
  String get email => _email;

  String _password = "";
  String get password => _password;

  bool get rememberMe => _rememberMe;

  AppEnv _appEnv;
  AppEnv get appEnv => _appEnv;

  StartUpViewModel();

  // List of environments
  List<AppEnv> availableEnvList = Configs.appEnvList;

  init() async {
    setBusy(true);
    _appEnv = availableEnvList.first;
    prefs = await _prefs;
    if (prefs.containsKey('rememberMe')) {
      _rememberMe = await prefs.getBool('rememberMe');
      await fetchUserCredentials();
    } else {
      _rememberMe = false;
    }
    setBusy(false);
  }

  toggleSavePassword(bool value) async {
    _rememberMe = await prefs.setBool('rememberMe', value);
    notifyListeners();
  }

  saveUserCredentials({String email, String password}) async {
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  fetchUserCredentials() async {
    if (prefs.containsKey('email')) {
      _email = await prefs.getString('email');
    }
    if (prefs.containsKey('password')) {
      _password = await prefs.getString('password');
    }
  }

  // Check if user has saved credentials
  setSavePassword(bool value) async {
    setBusy(true);

    setBusy(false);
    notifyListeners();
  }

  updateEnv(AppEnv appEnv) {
    _appEnv = appEnv;
    notifyListeners();
  }
}
