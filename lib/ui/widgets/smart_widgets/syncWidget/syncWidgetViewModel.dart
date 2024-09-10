import 'package:distributor/app/locator.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class SyncWidgetViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _logisticsService = locator<LogisticsService>();
  final _userService = locator<UserService>();

  Api get api => _apiService.api;
  User get user => _userService.user;

  List<Customer> _customerList = [];
  List<Customer> get customerList => _customerList;

  bool _status = false;
  bool get status => _status;
  setStatus(bool val) {
    _status = val;
    notifyListeners();
  }

  syncData() async {
    setBusy(true);
    await api.syncOfflineData(user: user);
    List customerList =
        await _apiService.api.fetchAllCustomers(_userService.user.token);
    await api.synchronizeData(
        user.token, user, _logisticsService.userJourneyList, customerList);

    setBusy(false);
    setStatus(true);
  }
}
