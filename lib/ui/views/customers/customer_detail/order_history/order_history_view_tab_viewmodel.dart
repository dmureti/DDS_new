import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';

import 'package:distributor/services/customer_service.dart';
import 'package:distributor/services/order_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class OrderHistoryTabViewModel extends ReactiveViewModel {
  DialogService _dialogService = locator<DialogService>();
  CustomerService _customerService = locator<CustomerService>();
  NavigationService _navigationService = locator<NavigationService>();
  OrderService _orderService = locator<OrderService>();
  SnackbarService _snackbarService = locator<SnackbarService>();

  final Customer customer;

  OrderHistoryTabViewModel({@required this.customer})
      : assert(customer != null);

  List<SalesOrder> get customerOrders => _customerService.salesOrderList;

  Future fetchCustomerOrders() async {
    var result =
        await _customerService.fetchOrdersByCustomer(customer.customerCode);
    notifyListeners();
  }

  navigateToOrder(SalesOrder salesOrder, DeliveryJourney deliveryJourney,
      String stopId) async {
    var result = await _navigationService.navigateTo(Routes.orderDetailView,
        arguments: OrderDetailViewArguments(
            salesOrder: salesOrder,
            deliveryJourney: deliveryJourney,
            stopId: stopId));
    if (result is bool) {
      await fetchCustomerOrders();
    }
  }

  init() async {
    await fetchCustomerOrders();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_orderService, _customerService];
}
