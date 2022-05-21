import 'package:distributor/app/locator.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';

class CrateReturnViewModel extends BaseViewModel {
  final _userService = locator<UserService>();

  bool _showElement = false;

  List<String> crateTxnTypes = ['Leave', 'Collect'];

  set crateTxnType(var c) {
    _crateTxnType = c;
    notifyListeners();
  }

  bool get showElement => _showElement;

  String _crateTxnType;
  String get crateTxnType => _crateTxnType;

  set showElement(bool val) {
    _showElement = val;
    notifyListeners();
  }
}
