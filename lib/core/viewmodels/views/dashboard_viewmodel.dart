import 'package:distributor/core/viewmodels/logistics_service.dart';
import 'package:tripletriocore/tripletriocore.dart';
import 'package:flutter/cupertino.dart';

class DashboardViewModel extends BaseModel {
  Api _api;
  Api get api => _api;

  final User _user;
  User get user => _user;

  LogisticsModel _logisticsModel;
  LogisticsModel get logisticsModel => _logisticsModel;

  DashboardViewModel(
      {User user, @required Api api, @required LogisticsModel logisticsModel})
      : _user = user,
        _api = api,
        _logisticsModel = logisticsModel,
        assert(api != null, user != null);

  List _paymentsReceived = List();
  List get paymentsReceived => _paymentsReceived;

  List<String> _customerFeedback = List<String>();
  List<String> get customerFeedback => _customerFeedback;
}
