import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class ChangePasswordViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  UserService _userService = locator<UserService>();

  init() async {
    if (_userService.user.status == 0) {
      await _dialogService.showDialog(
          title: 'Inactive account',
          description:
              'Your account is not activated.\nPlease log in to Web Application to activate it or contact the System Administrator');
    }
  }

  String _password;
  String get password => _password;

  String _oldPassword;
  String get oldPassword => _oldPassword;

  String _confirmPassword;
  String get confirmPassword => _confirmPassword;

  setOldPassword(String val) {
    if (val.isNotEmpty) {
      _oldPassword = val.trim();
      notifyListeners();
    }
  }

  setPassword(String val) async {
    if (val.isNotEmpty) {
      _password = val.trim();
      notifyListeners();
    }
  }

  bool _enableSubmit = false;
  bool get enableSubmit {
    if (password.isNotEmpty &&
        oldPassword.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        _enableSubmit = true;
      }
    }
    return _enableSubmit;
  }

  changePassword() async {
    setBusy(true);
    var result = await _userService.changePassword(oldPassword, password);
    setBusy(false);
    if (result is CustomException) {
      await _dialogService.showDialog(
          title: result.title, description: result.description);
    } else {
      await _dialogService.showDialog(
          title: 'Success',
          description: 'Your password was updated successfully.');
      _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
    }
  }

  setConfirmPassword(String val) {
    if (val.isNotEmpty) {
      _confirmPassword = val.trim();
      notifyListeners();
    }
  }

  setNewPassword(String val) {
    if (val.isNotEmpty) {
      _password = val.trim();
    }
  }
}
