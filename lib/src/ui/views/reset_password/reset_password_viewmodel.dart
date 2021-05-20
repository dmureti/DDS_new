import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/core/enums.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class ResetPasswordViewmodel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  UserService _userService = locator<UserService>();

  String _userId;
  String get userId => _userId;

  void resetPassword() async {
    setBusy(true);
    var result = await _userService.resetPassword(identityValue: userId);
    setBusy(false);
    if (result is CustomException) {
      await _dialogService.showDialog(
          title: result.title, description: result.description);
    } else {
      await _dialogService.showDialog(
          title: 'Success',
          description: 'Your password was reset successfully');
      _navigationService.pushNamedAndRemoveUntil(Routes.changePasswordView,
          arguments: ChangePasswordViewArguments(
              passwordChangeType: PasswordChangeType.reset,
              identityValue: userId));
    }
  }

  setUserId(String val) {
    if (val.isNotEmpty) {
      _userId = val.trim();
      notifyListeners();
    }
  }
}
