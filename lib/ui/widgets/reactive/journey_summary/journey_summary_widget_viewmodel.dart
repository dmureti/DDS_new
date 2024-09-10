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

  int _deliveriesCompleted;
  int _deliveriesPending;
  int _paymentsReceived;
  int _ordersMade;

  int get deliveriesCompleted => _deliveriesCompleted;
  int get deliveriesPending => _deliveriesPending;
  int get paymehtsReceived => _paymentsReceived;
  int get ordersMade => _ordersMade;

  getSummary() async {
    var result = await _userService.getUserSummary();
    if (result is UserSummary) {
      _paymentsReceived = result.payments;
      _ordersMade = result.ordersMade;
      _deliveriesPending = result.delivery_pending;
      _deliveriesCompleted = result.delivery_done;
    }
    notifyListeners();
  }

  int get ongoingJourney =>
      _logisticsService.userJourneyList
          .where((deliveryJourney) =>
              deliveryJourney.status.toLowerCase().contains('dispatched'))
          .length ??
      0;

  // int get completedJourney => userSummary.delivery_done ?? 0;
  // int get pendingJourney =>
  //     _logisticsService.userJourneyList
  //         .where((deliveryJourney) =>
  //             deliveryJourney.status.toLowerCase().contains('scheduled'))
  //         .length ??
  //     0;
  // int get paymentsReceived => _paymentsService.paymentsReceived ?? 0;
  // int get ordersMade => _orderService.ordersPlaced ?? 0;

  UserSummary _userSummary;
  UserSummary get userSummary => _userSummary;

  getUserSummary() async {
    var result = await _api.getUserSummary(_user.token, user: _user);
    if (result is UserSummary) {
      _userSummary = result;
      _deliveriesCompleted = userSummary.delivery_done;
      _deliveriesPending = userSummary.delivery_pending;
      _ordersMade = userSummary.ordersMade;
      _paymentsReceived = userSummary.payments;
      notifyListeners();
    }
  }

  init() async {
    // Check if this is a minishop
    if (!_user.hasSalesChannel) {
      await getUserSummary();
    } else {
      _userSummary = UserSummary(
          journeys: 0,
          delivery_pending: 0,
          delivery_done: 0,
          payments: 0,
          ordersMade: 0);
      _deliveriesCompleted = userSummary.delivery_done;
      _deliveriesPending = userSummary.delivery_pending;
      _ordersMade = userSummary.ordersMade;
      _paymentsReceived = userSummary.payments;
      notifyListeners();
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_logisticsService, _orderService, _paymentsService];
}
