import 'package:distributor/app/locator.dart';
import 'package:distributor/services/api_service.dart';
import 'package:distributor/services/logistics_service.dart';
import 'package:distributor/services/order_service.dart';
import 'package:distributor/services/payments_service.dart';

import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:tripletriocore/tripletriocore.dart';

class JourneySummaryWidgetViewModel extends ReactiveViewModel {
  LogisticsService _logisticsService = locator<LogisticsService>();
  OrderService _orderService = locator<OrderService>();
  PaymentsService _paymentsService = locator<PaymentsService>();

  ApiService _apiService = locator<ApiService>();
  UserService _userService = locator<UserService>();

  Api get _api => _apiService.api;
  User get _user => _userService.user;

  int get ongoingJourney =>
      _logisticsService.userJourneyList
          .where((deliveryJourney) =>
              deliveryJourney.status.toLowerCase().contains('in transit'))
          .length ??
      0;

  int get completedJourney =>
      _logisticsService.userJourneyList
          .where((deliveryJourney) =>
              deliveryJourney.status.toLowerCase().contains('completed'))
          .length ??
      0;
  int get pendingJourney =>
      _logisticsService.userJourneyList
          .where((deliveryJourney) =>
              deliveryJourney.status.toLowerCase().contains('scheduled'))
          .length ??
      0;
  int get paymentsReceived => _paymentsService.paymentsReceived ?? 0;
  int get ordersMade => _orderService.ordersPlaced ?? 0;

  UserSummary _userSummary;
  UserSummary get userSummary => _userSummary;

  getUserSummary() async {
    var result = await _api.getUserSummary(_user.token, userId: _user.email);
    return result;
  }

  init() async {
    setBusy(true);
    _userSummary = await getUserSummary();
    setBusy(false);
    return _userSummary;
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_logisticsService, _orderService, _paymentsService];
}
