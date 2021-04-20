import 'package:distributor/app/locator.dart';
import 'package:distributor/app/router.gr.dart';

import 'package:distributor/services/customer_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tripletriocore/tripletriocore.dart';

class OrderHistoryTabViewModel extends FutureViewModel {
  DialogService _dialogService = locator<DialogService>();
  CustomerService _customerService = locator<CustomerService>();
  NavigationService _navigationService = locator<NavigationService>();
  final Customer customer;

  OrderHistoryTabViewModel({@required this.customer})
      : assert(customer != null);

  List<SalesOrder> _customerOrders;
  List<SalesOrder> get customerOrders => _customerOrders;

  Future fetchCustomerOrders() async {
    List<SalesOrder> result =
        await _customerService.fetchOrdersByCustomer(customer.id);
    if (result is List<SalesOrder>) {
      _customerOrders = result;
      notifyListeners();
    }
    return result;
  }

  navigateToOrder(SalesOrder salesOrder, DeliveryJourney deliveryJourney,
      String stopId) async {
    var result = await _navigationService.navigateTo(Routes.orderDetailView,
        arguments: OrderDetailViewArguments(
            salesOrder: salesOrder,
            deliveryJourney: deliveryJourney,
            stopId: stopId));
    print(result);
    if (result is bool) {
      await fetchCustomerOrders();
    }
  }

  @override
  Future futureToRun() => fetchCustomerOrders();

  @override
  void onError(error) {
    _dialogService.showDialog(title: 'Error', description: 'Error');
  }

  @override
  void onData(data) {
    _customerOrders = data;
    super.onData(data);
  }
}
