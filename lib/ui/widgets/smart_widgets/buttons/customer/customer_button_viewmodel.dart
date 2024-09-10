import 'package:distributor/app/locator.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class CustomerButtonViewModel extends BaseViewModel {
  final UserService _userService = locator<UserService>();
  User get user => _userService.user;

  CustomerButtonViewModel() {}

  bool _isEnabled;
  bool get isEnabled => _isEnabled;

  //Run this when the model is ready
  init() {
    _isEnabled = true;
    notifyListeners();
  }
}
