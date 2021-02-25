import 'package:tripletriocore/tripletriocore.dart';
import 'package:flutter/widgets.dart';

class LoginViewModel extends BaseModel {
  AuthenticationService _authenticationService;
  bool canSubmit = false;

  String _versionName;
  String get versionName => _versionName;

  String _emailValidationMessage;
  String get emailValidationMessage => _emailValidationMessage;

  String _passwordValidationMessage;
  String get passwordValidationMessage => _passwordValidationMessage;

  resetValidation() {
    _emailValidationMessage = null;
    _passwordValidationMessage = null;
    notifyListeners();
  }

  LoginViewModel({
    @required AuthenticationService authenticationService,
  })  : _authenticationService = authenticationService,
        assert(authenticationService != null);

  Future<bool> login({String email, String password}) async {
    if (email.trim().length == 0) {
      _emailValidationMessage = "Email cannot be empty";
      return false;
    }
    if (password.trim().length == 0 || password == null) {
      _passwordValidationMessage = "Password cannot be empty";
      return false;
    }

    bool result = await _authenticationService.loginWithEmailAndPassword(
        email: email.trim(), password: password.trim());

    return result;
  }
}
