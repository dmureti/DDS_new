import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/core/enums.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class ChangePasswordViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  UserService _userService = locator<UserService>();

  final PasswordChangeType passwordChangeType;
  final identityValue;

  ChangePasswordViewModel(this.passwordChangeType, this.identityValue);

  String get introTextToDisplay {
    String introText = "";
    switch (passwordChangeType) {
      case PasswordChangeType.initial:
        introText =
            "Enter the password you received via email or sms as the old password";
        break;
      case PasswordChangeType.reset:
        introText =
            "To complete the password reset process, please enter the temporary password you received via email or SMS.";
        break;
      case PasswordChangeType.user:
        introText = "Enter your old password";
        break;
      default:
        introText =
            "If this is your first time to use the app, please use the Temporary password you received via SMS or email as the old password";
        break;
    }
    return introText;
  }

  authenticateUser() async {}

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
    if (password != null &&
        oldPassword != null &&
        confirmPassword != null &&
        password.isNotEmpty &&
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
    var result;
    switch (passwordChangeType) {
      case PasswordChangeType.reset:
        result = await _userService.completeResetMyPassword(
            identityValue: identityValue,
            password: password,
            resetCode: oldPassword);
        break;
      default:
        result = await _userService.changePassword(oldPassword, password);
        break;
    }
    setBusy(false);
    if (result is CustomException) {
      await _dialogService.showDialog(
          title: result.title, description: result.description);
    } else {
      await _dialogService.showDialog(
          title: 'Success',
          description:
              'Your password was updated successfully. Please sign in again with your new password');
      // Get the user again
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
      notifyListeners();
    }
  }
}
