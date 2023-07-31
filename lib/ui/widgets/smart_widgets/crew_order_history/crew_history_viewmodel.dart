import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';
import 'package:distributor/services/order_service.dart';
import 'package:distributor/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class CrewHistoryViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _orderService = locator<OrderService>();
  final _userService = locator<UserService>();

  String get token => _userService.user.token;

  List<SalesOrder> _orders = [];
  List<SalesOrder> get orders => _orders;

  init() async {
    await fetchOrders();
  }

  //fetch all orders
  fetchOrders() async {
    setBusy(true);
    var result = await _orderService.fetchOrdersByUser(token);
    if (result) {
      _orders = result;
    }
    setBusy(false);
    notifyListeners();
  }

  navigateToSalesOrder(SalesOrder salesOrder,
      {DeliveryJourney deliveryJourney, String stopId}) async {
    await _navigationService.navigateTo(Routes.orderDetailView,
        arguments: OrderDetailViewArguments(
            salesOrder: salesOrder,
            deliveryJourney: deliveryJourney,
            stopId: stopId));
    await fetchOrders();
  }

  navigateToOrder(SalesOrder salesOrder, DeliveryJourney deliveryJourney,
      String stopId) async {}

  syncOrder() {}
}
